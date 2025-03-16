pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "2022bcd0038-chaitan/javaapp" 
        DOCKER_REGISTRY = "docker.io" // Docker registry (Docker Hub)
    }

    stages {
        // Stage 1: Pull code from Git
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Chaitan2004/javaapp' 
            }
        }

        // Stage 2: Build the project using Maven
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        // Stage 3: Run SonarQube analysis
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        // Stage 4: Build Docker image
        stage('Docker Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        // Stage 5: Push Docker image to Docker Hub
        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", 'dockerhub-credentials') {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }

        // Stage 6: Deploy Docker container
        stage('Deploy') {
            steps {
                sh "docker run -d -p 9090:8080 ${DOCKER_IMAGE}"
            }
        }
    }
}