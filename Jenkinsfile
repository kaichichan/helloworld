pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = "kaichichan1"
        APP_NAME = "helloworld"
        // Uses BUILD_NUMBER provided by Jenkins
        IMAGE_TAG = "${env.BUILD_NUMBER}" 
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/dev']],
                    extensions: [],
                    userRemoteConfigs: [[
                        url: 'https://github.com/kaichichan/helloworld.git',
                        credentialsId: 'git-creds'
                    ]]
                ])
            }
        }
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
