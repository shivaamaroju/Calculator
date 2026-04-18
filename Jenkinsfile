pipeline {
    agent any
    environment {
        DOCKER_USER = "shivaamaroju"
        IMAGE_NAME = "java-calculator"
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/shivaamaroju/Calculator.git'
            }
        }
        stage('Docker Build & Push') {
            steps {
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
                withCredentials([usernamePassword(credentialsId: 'docker-hub-token', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo \$PASS | docker login -u \$USER --password-stdin"
                    sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Run Container') {
            steps {
                // పాత కంటైనర్ ఉంటే డిలీట్ చేసి కొత్తది రన్ చేస్తుంది
                sh "docker rm -f java-app || true"
                sh "docker run -d --name java-app -p 8081:8081 ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }
    }
}
