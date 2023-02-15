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

       stage('Deploy to K8s'){
            steps{
                script{
                      kubernetesDeploy (configs: 'deploy-all.yaml',kubeconfigId: 'kubeconfig')
                }
            }
       }


    }
}