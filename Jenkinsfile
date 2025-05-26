pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = "kaichichan1"
        APP_NAME = "helloworld"
        // Uses BUILD_NUMBER provided by Jenkins
        IMAGE_TAG = "${env.BUILD_NUMBER}" 
    }
    stages {
        stage('Build and Push') {
            steps {
                script {
                    docker.build("${DOCKER_REGISTRY}/${APP_NAME}:${IMAGE_TAG}")
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        docker.image("${DOCKER_REGISTRY}/${APP_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }
    }
}