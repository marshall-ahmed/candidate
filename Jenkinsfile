pipeline {
   agent any

   environment {
     // You must set the following environment variables
     // ORGANIZATION_NAME
     // YOUR_DOCKERHUB_USERNAME (it doesn't matter if you don't have one)
     YOUR_DOCKERHUB_USERNAME = "namrahov"
     ORGANIZATION_NAME = "marshall-ahmed"
     SERVICE_NAME = "candidate"
     REPOSITORY_TAG = "${YOUR_DOCKERHUB_USERNAME}/${ORGANIZATION_NAME}-${SERVICE_NAME}:${BUILD_ID}"
   }

   stages {
      stage('Preparation') {
         steps {
            cleanWs()
            git credentialsId: 'hesen', url: "https://github.com/${ORGANIZATION_NAME}/${SERVICE_NAME}"
         }
      }

      stage ('Package') {
         steps {
           sh './gradlew build -x test'
         }
      }

      stage('Build Image') {
         steps {
           sh 'docker build -t candidate-image:${BUILD_ID} .'
         }
      }

      stage('Create Tag') {
         steps t
             sh 'docker tag candidate-image:${BUILD_ID} namrahov/candidate-image:${BUILD_ID}'
          }
      }


      stage ('Push docker image to image repository') {
         steps {
             script {
                sh "docker push namrahov/candidate-image:${BUILD_ID}"
             }
          }
      }

      stage('Deploy to Cluster') {
          steps {
                    sh 'envsubst < ${WORKSPACE}/deploy-all.yaml | kubectl apply -f -'
          }
      }
   }
}

 docker build -t company-image:0.0.9 .

   docker tag company-image:0.0.9 namrahov/company-image:0.0.9

   docker push namrahov/company-image:0.0.9
