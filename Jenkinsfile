pipeline {
    agent any
    tools {
        maven 'mvn'
    }
    stages{
        stage('GIT checkout') {
            steps {
                git credentialsId: 'github_cred', url: 'https://github.com/u16052642/CalTech-PG-DevOps-Final-Capstone-Project.git'
           }
       }
          stage('Build Package using Maven') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Docker build and Tag') {
            steps{
                sh 'docker build -t ${JOB_NAME}:v1.${BUILD_NUMBER} .'
                sh 'docker tag ${JOB_NAME}:v1.${BUILD_NUMBER} softbayx/${JOB_NAME}:v1.${BUILD_NUMBER} '
                sh 'docker tag ${JOB_NAME}:v1.${BUILD_NUMBER} softbayx/${JOB_NAME}:latest '
            }
        }
        stage('push conatiner') {
            steps{
                withCredentials([string(credentialsId: 'Docker_hub_password', variable: 'VAR_FOR_DOCKERPASS')]) {
                  sh 'docker login -u softbayx -p ${VAR_FOR_DOCKERPASS}'
                  sh 'docker push softbayx/${JOB_NAME}:v1.${BUILD_NUMBER}'
                  sh 'docker push softbayx/${JOB_NAME}:latest'
                  sh 'docker rmi ${JOB_NAME}:v1.${BUILD_NUMBER} softbayx/${JOB_NAME}:v1.${BUILD_NUMBER} softbayx/${JOB_NAME}:latest'
                }      
            }
        }
        //deploy using ansible playbook
        stage('Docker Deploy') {
            steps{
                ansiblePlaybook credentialsId: 'ansible-host', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory.txt', playbook: 'deploy.yml'
            }
        }          
    }
}
