pipeline {
  agent any

    stages {
        stage('Build Gradle') {
            steps {
                 checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/marshall-ahmed/candidate.git']])
                 sh './gradlew assemble'
            }
        }


	   stage('Build docker image') {
             steps {
                 script {
                    sh 'docker build -t namrahov/candidate-image .'
                 }
            }
       }

       stage('Push image to hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                         sh 'docker login -u namrahov -p ${dockerhubpwd}'
                    }
                         sh 'docker push namrahov/candidate-image'
                }
            }
       }

       stage("Install kubectl"){
            steps {
                sh """
                    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
                    chmod +x ./kubectl
                    ./kubectl version --client
                """
            }
        }

       stage('Deploy to K8s'){
            steps{
                sh "aws eks update-kubeconfig --region eu-central-1 --name orxan"
                sh " envsubst < ${WORKSPACE}/deploy-all.yaml | ./kubectl apply -f - "
            }
       }


    }
}