@Library('jenkins-shared-library@master') _
pipeline {
    environment {
       account = "${environment}"
       eks_cluster_name = "eks-${account}"
       artifacts_dir = "${env.WORKSPACE}/artifacts"
       aws_region = "${params.aws_region}"
       job_root_dir="${env.WORKSPACE}"
    }

  agent any

  parameters {
	choice(name: 'action', choices: 'create\nrollback', description: 'Create/rollback of the deployment')
    string(name: 'ImageName', description: "Name of the docker build")
	string(name: 'ImageTag', description: "Name of the docker build")
	string(name: 'AppName', description: "Name of the Application")
    string(name: 'docker_repo', description: "Name of docker repository")
  }


    stages {
        stage('Git Checkout') {
            when {
				expression { params.action == 'create' }
			}
            steps {
                gitCheckout(
                    branch: "master",
                    url: "https://github.com/marshall-ahmed/candidate.git"
                )
            }
        }
        stage('Build Gradle'){
            when {
				expression { params.action == 'create' }
			}
    		steps {
        		dir("${params.AppName}") {
        			sh './gradlew assemble'
        		}
    		}
	    }
	    stage('Generate kubeconfig for the cluster') {
            steps {
               script {
                   env.KUBECONFIG = "${artifacts_dir}/${eks_cluster_name}-kubeconfig"
                   sh 'chmod +x ${WORKSPACE}/generate_kubeconfig_eks.sh'
               }
                   sh(script: '${WORKSPACE}/generate_kubeconfig_eks.sh', label: 'Generate kubeconfig file')
             }
        }

	    stage("Docker Build and Push") {
	        when {
				expression { params.action == 'create' }
			}
	        steps {
	            dir("${params.AppName}") {
	                dockerBuild ( "${params.ImageName}", "${params.docker_repo}" )
	            }
	        }
	    }
	    stage("Docker CleanUP") {
	        when {
				expression { params.action == 'create' }
			}
	        steps {
	            dockerCleanup ( "${params.ImageName}", "${params.docker_repo}" )
			}
		}
	    stage("Create deployment") {
			when {
				expression { params.action == 'create' }
			}
	        steps {
	            dir("${params.AppName}") {
	                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
	                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
	                        credentialsId: 'AWS_Credentials',
	                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
	                  sh 'kubectl create -f deploy-all.yaml'
	                }
	            }
	        }
	    }

    }
}