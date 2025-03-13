pipeline {
    agent any

    environment {
        // Define the environment variables here
        DOCKER_IMAGE = "node-app-test-new"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    // Checkout the latest code from GitHub repository
                    echo 'Checking out code from GitHub...'
                    checkout scm
                }
            }
        }

        stage('Build and Test') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'

                    echo 'Updating npm to the latest version inside the container...'
                    sh 'docker run --rm $DOCKER_IMAGE:$DOCKER_TAG npm install -g npm@latest'

                    echo 'Running npm install for dependencies...'
                    sh 'docker run --rm $DOCKER_IMAGE:$DOCKER_TAG npm install'

                    echo 'Running tests if available...'
                    // Add your testing commands here if needed, like `npm test` or other commands
                    // sh 'docker run --rm $DOCKER_IMAGE:$DOCKER_TAG npm test'
                }
            }
        }

        stage('Scan Image') {
            steps {
                echo 'Skipping scan image due to earlier failure or optional stage.'
                // You can integrate security scanning here using tools like Trivy, Snyk, etc.
            }
        }

        stage('Push Image') {
            steps {
                echo 'Skipping image push due to earlier failure or optional stage.'
                // Add the docker push commands here if you want to push the image to a registry
                // sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Skipping deploy due to earlier failure or optional stage.'
                // You can integrate Kubernetes deployments, Helm charts, or other deployment strategies here.
                // Example: kubectl apply -f k8s/deployment.yaml
            }
        }
    }

    post {
        always {
            echo 'Cleaning up resources...'
            // You can clean up Docker images or other resources here if needed
            // sh 'docker system prune -f'
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed, please check the logs for details.'
        }
    }
}
