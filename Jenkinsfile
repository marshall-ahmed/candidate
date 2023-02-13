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
	   stage('Deploy App to Kubernetes') {
         steps {
           script {
             kubernetesDeploy(configs: "deploy-all.yaml", kubeconfigId: "kubernetes")
           }
         }
       }


    }
}