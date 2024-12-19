pipeline {
    agent any
    stages {
        stage('Git checkout') {
            steps {
                echo 'Cloning repository from GitHub...'
                checkout([$class: 'GitSCM', branches: [[name: '*/master']],
                          userRemoteConfigs: [[url: 'https://github.com/vnvarf/tubesCloud.git']]])
            }
        }
        stage('Sending Dockerfile to Ansible server') {
            steps {
                echo 'Sending Dockerfile to Ansible server...'
                sh '''
                scp Dockerfile user@54.79.72.164:/path/to/destination
                '''
            }
        }
        stage('Docker build image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t vanvaa .'
            }
        }
        stage('Push Docker images to DockerHub') {
            steps {
                echo 'Pushing Docker image to DockerHub...'
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
                    sh 'docker push vnvarf17/tubes_cloud'
                }
            }
        }
        stage('Copy files to Kubernetes server') {
            steps {
                echo 'Copying files to Kubernetes server...'
                sh '''
                scp -r ./files user@kubernetes-server:/path/to/destination
                '''
            }
        }
        stage('Kubernetes deployment using Ansible') {
            steps {
                echo 'Deploying to Kubernetes using Ansible...'
                sh '''
                ansible-playbook -i inventory.yml deploy.yml
                '''
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution finished.'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
