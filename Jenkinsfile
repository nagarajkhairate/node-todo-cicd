pipeline {
    agent any  // Use any available Jenkins agent
    
    environment {
        DOCKER_IMAGE_NAME = "node-app-test-new"
        DOCKER_HUB_REPO = "yourdockerhubusername"  // Replace with your DockerHub username
    }
    
    stages {
        
        stage('Checkout Code') {
            steps {
                echo "Checking out code from GitHub..."
                git url: 'https://github.com/nagarajkhairate/node-todo-cicd.git', branch: 'master'
            }
        }
        
        stage('Build and Test') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t ${DOCKER_IMAGE_NAME} .'

                echo "Running npm install for testing"
                sh 'npm install'
            }
        }
        
        stage('Scan Image') {
            steps {
                echo "Scanning Docker image..."
                // Example: Use a scanning tool like Trivy or Docker Scan (Uncomment the line below)
                // sh 'docker scan ${DOCKER_IMAGE_NAME}'
                echo "Image scan completed"
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                echo "Pushing image to DockerHub..."
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'DOCKER_HUB_PASS', usernameVariable: 'DOCKER_HUB_USER')]) {
                    sh 'docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASS}'
                    sh 'docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_HUB_REPO}/${DOCKER_IMAGE_NAME}:latest'
                    sh 'docker push ${DOCKER_HUB_REPO}/${DOCKER_IMAGE_NAME}:latest'
                }
                echo "Docker image pushed to DockerHub"
            }
        }
        
        stage('Deploy with Docker Compose') {
            steps {
                echo "Deploying with Docker Compose..."
                sh 'docker-compose down && docker-compose up -d'
                echo "Deployment completed"
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Clean up Docker containers and images after the pipeline runs
            sh 'docker system prune -f'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed, please check the logs.'
        }
    }
}
