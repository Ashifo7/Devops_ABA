pipeline {
    agent any

    environment {
        IMAGE_NAME = "ci-cd-demo"
        DOCKER_REPO = "ashif321"
    }

   tools {
    maven 'Maven-3.9.9'
}

    stages {
        stage('Build with Maven') {
            steps {
                echo 'Building with Maven...'
                sh 'mvn clean package -DskipTests'
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
        }
    }

    post {
        success {
            mail to: 'mdashifr08@gmail.com',
                 subject: "Jenkins Job SUCCESS: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                 body: "Good news!\n\nJob '${env.JOB_NAME} [#${env.BUILD_NUMBER}]' completed successfully.\n\nCheck details at ${env.BUILD_URL}"
        }

        failure {
            mail to: 'mdashifr08@gmail.com',
                 subject: "Jenkins Job FAILED: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
                 body: "Something went wrong.\n\nJob '${env.JOB_NAME} [#${env.BUILD_NUMBER}]' failed.\n\nCheck logs at ${env.BUILD_URL}"
        }
    }
}
