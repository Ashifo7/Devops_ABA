pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "mdashifr/ci-cd-demo"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Ashifo7/Devops_ABA.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'docker build -t $DOCKER_IMAGE .'
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }

    post {
        success {
            mail to: 'mdashifr08@gmail.com',
                 subject: '✅ Build Successful',
                 body: 'Your Jenkins build completed successfully and the Docker image was pushed to Docker Hub.'
        }
        failure {
            mail to: 'mdashifr08@gmail.com',
                 subject: '❌ Build Failed',
                 body: 'Your Jenkins build failed. Please check the logs in Jenkins.'
        }
    }
}
