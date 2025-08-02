pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'balaji5667/mediplus-lite'  // Docker Hub image
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // Jenkins credentials ID
        PROJECT_DIR = 'mediplus-lite'  // Your renamed folder
    }

    stages {
        stage('Verify Files') {
            steps {
                // Debug: Show workspace structure
                bat 'tree /F /A'  

                // Check if project folder exists
                bat 'if not exist "%PROJECT_DIR%" (echo ERROR: Folder "%PROJECT_DIR%" missing! && exit 1)'

                // Verify index.html exists
                bat 'if exist "%PROJECT_DIR%\\index.html" (echo index.html found!) else (echo ERROR: index.html missing! && exit 1)'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir(env.PROJECT_DIR) {  // Enter project folder
                    bat 'docker build -t %DOCKER_IMAGE% .'
                }
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
            cleanWs()  // Clean workspace
        }
        failure {
            slackSend channel: '#builds', message: "Build failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
        }
    }
}
