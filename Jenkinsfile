@Library('jenkins-shared-library@master') _
pipeline {

  agent any

  parameters {
	choice(name: 'action', choices: 'create\nrollback', description: 'Create/rollback of the deployment')
    string(name: 'ImageName', description: "Name of the docker build")
	string(name: 'ImageTag', description: "Name of the docker build")
	string(name: 'AppName', description: "Name of the Application")
    string(name: 'docker_repo', description: "Name of docker repository")
  }


    stages {
        stage('List pods') {
           sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'
           sh 'chmod u+x ./kubectl'
           sh './kubectl get pods'
        }

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