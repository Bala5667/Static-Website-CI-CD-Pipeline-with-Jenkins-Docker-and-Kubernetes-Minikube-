pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'balaji5667/mediplus-lite'       // ✅ your DockerHub image name
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'       // ✅ Jenkins credential ID
    }

    stages {
        stage('Test') {
            steps {
                echo 'Testing HTML & CSS...'
                bat 'dir index.html'                     // ✅ Windows command to check HTML file
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t %DOCKER_IMAGE% .'  // ✅ Windows Docker build
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %DOCKER_IMAGE%
                    """
                }
            }
        }
    }
}
