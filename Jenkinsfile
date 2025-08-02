pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'balaji5667/mediplus-lite'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds' // Jenkins credential ID
    }

    stages {
        stage('Test') {
            steps {
                echo 'Testing HTML & CSS...'
                bat 'ls -l index.html' // or `dir` if Windows
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    bat 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }
}
