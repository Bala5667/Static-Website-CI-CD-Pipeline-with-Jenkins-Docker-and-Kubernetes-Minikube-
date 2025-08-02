pipeline {
    agent any

    environment {
        IMAGE_NAME = "yourdockerhubusername/static-website"
        TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Checking HTML and CSS files...'
                sh 'ls -l'
            }
        }

        stage('Test') {
            steps {
                echo 'Running basic HTML lint (optional)'
                // You can install htmlhint globally and use it here, or skip this
                sh 'echo "Simulated test: Checking index.html exists..."'
                sh '[ -f index.html ] || (echo "index.html missing!" && exit 1)'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${TAG}")
                }
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        sh "docker push ${IMAGE_NAME}:${TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed."
        }
    }
}
