pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'balaji5667/mediplus-lite'  // Docker Hub image
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'  // Jenkins credentials ID
        PROJECT_DIR = 'mediplus-lite'  // Folder with your HTML/CSS
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Verify Files') {
            steps {
                // Debug: Show workspace structure
                bat 'tree /F /A'

                // Check if project folder exists
                bat 'if not exist "%PROJECT_DIR%" (echo ERROR: Folder "%PROJECT_DIR%" missing! && exit 1)'

                // Verify index.html exists inside the folder
                bat 'if exist "%PROJECT_DIR%\\index.html" (echo index.html found!) else (echo ERROR: index.html missing! && exit 1)'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE% .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: env.DOCKER_CREDENTIALS_ID,
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                        bat 'docker push %DOCKER_IMAGE%'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            echo "Build failed!"
            // Optional Slack or notification step
        }
    }
}
