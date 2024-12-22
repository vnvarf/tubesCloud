pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "tubes_cloud"
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        DOCKER_REPO = 'vnvarf17/tubes_cloud'
        DOCKER_CREDENTIALS = 'vnvarf17' // ID kredensial di Jenkins
        PATH = "/usr/local/bin:$PATH"  // Tambahkan lokasi Docker CLI ke PATH
        DOCKER_PASSWORD = 'dckr_pat_09ZQN5WPswHBfWNnEeNN2vYZ5To'
        DOCKER_USERNAME = 'vnvarf17'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/vnvarf/tubesCloud'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Perintah build Docker
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login dan push ke Docker registry
                    sh """
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin ${DOCKER_REGISTRY}
                        docker tag ${DOCKER_IMAGE}:latest ${DOCKER_REPO}:latest
                        docker push ${DOCKER_REPO}:latest
                    """
                }
            }
        }
    }
}
