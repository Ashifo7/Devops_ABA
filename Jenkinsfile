pipeline {
    agent any

    environment {
        IMAGE_NAME = "ci-cd-demo"
        DOCKER_REPO = "ashif321"
    }

    tools {
        maven 'Maven-3.9.9' // Adjust this if your tool name is different
    }

    stages {
        stage('Build with Maven') {
            steps {
                echo 'Building project using Maven...'
                sh 'mvn clean package -DskipTests'
            }
            post {
                success {
                    mail to: 'mdashifr08@gmail.com',
                         subject: "STAGE SUCCESS: Build with Maven - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                         body: "The 'Build with Maven' stage completed successfully.\n\nCheck: ${env.BUILD_URL}"
                }
                failure {
                    mail to: 'mdashifr08@gmail.com',
                         subject: "STAGE FAILURE: Build with Maven - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                         body: "The 'Build with Maven' stage failed.\n\nCheck logs: ${env.BUILD_URL}"
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                echo 'Building and pushing Docker image...'
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh """
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker build -t $DOCKER_REPO/$IMAGE_NAME .
                        docker push $DOCKER_REPO/$IMAGE_NAME
                    """
                }
            }
            post {
                success {
                    mail to: 'mdashifr08@gmail.com',
                         subject: "STAGE SUCCESS: Docker Build & Push - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                         body: "The 'Docker Build & Push' stage completed successfully.\n\nCheck: ${env.BUILD_URL}"
                }
                failure {
                    mail to: 'mdashifr08@gmail.com',
                         subject: "STAGE FAILURE: Docker Build & Push - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                         body: "The 'Docker Build & Push' stage failed.\n\nCheck logs: ${env.BUILD_URL}"
                }
            }
        }
    }

    post {
        success {
            mail to: 'mdashifr08@gmail.com',
                 subject: "BUILD SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The Jenkins job '${env.JOB_NAME} #${env.BUILD_NUMBER}' completed successfully.\n\nSee details: ${env.BUILD_URL}"
        }
        failure {
            mail to: 'mdashifr08@gmail.com',
                 subject: "BUILD FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The Jenkins job '${env.JOB_NAME} #${env.BUILD_NUMBER}' failed.\n\nSee details: ${env.BUILD_URL}"
        }
    }
}
