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

        // Stage 2: Build the project using Maven (Windows-friendly)
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        // Stage 3: Run SonarQube analysis (Windows-friendly)
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    bat 'mvn sonar:sonar'
                }
            }
        }

        // Stage 4: Build Docker image
        stage('Docker Build') {
            steps {
                script {
                    bat "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        // Stage 5: Push Docker image to Docker Hub
        stage('Docker Push') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-credentials', url: "https://${DOCKER_REGISTRY}"]) {
                        bat "docker push ${DOCKER_IMAGE}"
                    }
                }
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
