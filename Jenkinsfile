pipeline {
    agent any  // Use the default agent, not a specific label
    
    stages {
        
        stage("code") {
            steps {
                git url: "https://github.com/nagarajkhairate/node-todo-cicd.git", branch: "master"
                echo 'Bhaiyya, code clone ho gaya'
            }
        }

        stage("build and test") {
            steps {
                // Update npm to the latest version
                sh 'npm install -g npm@latest'
                
                // Now run the npm install
                sh 'npm install'
                
                // Build Docker image
                sh "docker build -t node-app-test-new ."
                echo 'Code build ho gaya'
            }
        }

        stage("scan image") {
            steps {
                echo 'Image scanning ho gayi'
            }
        }

        stage("push") {
            steps {
                withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker tag node-app-test-new:latest ${env.dockerHubUser}/node-app-test-new:latest"
                    sh "docker push ${env.dockerHubUser}/node-app-test-new:latest"
                    echo 'Image push ho gayi'
                }
            }
        }

        stage("deploy") {
            steps {
                sh "docker-compose down && docker-compose up -d"
                echo 'Deployment ho gayi'
            }
        }
    }
}
