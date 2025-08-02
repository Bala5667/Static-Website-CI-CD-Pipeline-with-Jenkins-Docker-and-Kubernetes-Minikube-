pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'balaji5667/mediplus-lite'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Jenkins Credentials ID
    }

    stages {
        stage('Clone Repo') {
            steps {
                echo 'Cloning repository...'
                // Jenkins does this by default if the project is connected to GitHub
            }
        }

        stage('Test HTML file exists') {
            steps {
                echo 'Checking if index.html exists...'
                bat 'dir index.html'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    bat "docker build -t %DOCKER_IMAGE% ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        echo "Logging into Docker Hub..."
                        bat "docker login -u %USERNAME% -p %PASSWORD%"
                        echo "Pushing image to Docker Hub..."
                        bat "docker push %DOCKER_IMAGE%"
                    }
                }
            }
        }
    }
}
