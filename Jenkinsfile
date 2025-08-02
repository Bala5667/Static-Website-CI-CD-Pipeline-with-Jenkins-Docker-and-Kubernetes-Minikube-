pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'balaji5667/mediplus-lite'           // Docker Hub repo
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'           // Jenkins Credential ID
        PROJECT_DIR = 'mediplus-lite'                       // HTML+CSS project folder
    }

    stages {
        stage('Verify Files') {
            steps {
                bat 'echo Checking workspace...'
                bat 'tree /F /A'
                bat 'if not exist "%PROJECT_DIR%" (echo ERROR: Folder %PROJECT_DIR% not found! && exit 1)'
                bat 'if not exist "%PROJECT_DIR%\\index.html" (echo ERROR: index.html not found! && exit 1)'
                bat 'echo ✅ Project structure looks good.'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir(env.PROJECT_DIR) {
                    bat "docker build -t %DOCKER_IMAGE% ."
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
                        bat 'echo Logging in to Docker...'
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
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
            echo "❌ Build failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
        }
    }
}
