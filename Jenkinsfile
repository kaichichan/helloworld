pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "kaichichan1"
        APP_NAME = "helloworld"
        // Uses BUILD_NUMBER provided by Jenkins
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        KUBE_DEPLOYMENT_FILE = 'deployment.yaml'
        NAMESPACE= 'helloworld'
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
                    docker.build("${DOCKER_REGISTRY}/${APP_NAME}:latest")
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        //docker.image("${DOCKER_REGISTRY}/${APP_NAME}:${IMAGE_TAG}").push()
			docker.image("${DOCKER_REGISTRY}/${APP_NAME}:latest").push()
                    }
                }
            }
        }
        stage('Apply Kubernetes Manifest') {
            steps {
                script {
                    // 1. Ensure kubectl is correctly configured on the agent.
                    // If you mounted the ~/.kube/config file, it should work.
                    // You can run 'kubectl config current-context' to verify.
                    echo "Verifying kubectl connection..."
                    sh 'kubectl cluster-info'

                    // 2. Apply the deployment manifest.
                    // This command uses the locally built image.
                    echo "Applying Kubernetes manifest..."
                    sh "kubectl apply -f ${KUBE_DEPLOYMENT_FILE} -n ${NAMESPACE}"

                    // 3. Wait for the deployment to roll out successfully.
                    echo "Waiting for deployment rollout..."
                    sh "kubectl rollout status deployment/${APP_NAME}-deployment --timeout=300s -n ${NAMESPACE}"
                }
            }
        }
    }
}
