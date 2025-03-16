pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "chaitan2004/2022bcd0038-chaitan-javaapp"
        DOCKER_REGISTRY = "docker.io" // Docker registry (Docker Hub)
    }

    stages {
        // Stage 1: Pull code from Git
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Chaitan2004/javaapp' 
            }
        }

        // Stage 2: Build the project using Maven (Fixed for Windows)
        stage('Build') {
            steps {
                bat '"C:\\apache-maven-3.9.9\\bin\\mvn" clean package'
            }
        }

        // Stage 3: Run SonarQube analysis (Fixed for Windows)
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    bat '"C:\\apache-maven-3.9.9\\bin\\mvn" sonar:sonar'
                }
            }
        }

        // Stage 4: Build Docker image
        stage('Docker Build') {
            steps {
                bat "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        // Stage 5: Push Docker image to Docker Hub
        stage('Docker Push') {
            steps {
                bat """
                docker login -u YOUR_DOCKER_USERNAME -p YOUR_DOCKER_PASSWORD
                docker push ${DOCKER_IMAGE}
                """
            }
        }

        // Stage 6: Deploy Docker container
        stage('Deploy') {
            steps {
                bat "docker run -d -p 9090:8080 ${DOCKER_IMAGE}"
            }
        }
    }
}
