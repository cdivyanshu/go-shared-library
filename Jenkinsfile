pipeline {
    agent any
    
    stages {
        stage('Load Bugs Analysis') {
            steps {
                script {
                    def bugsAnalysis = load "${WORKSPACE}/src/BugsAnalysis.groovy"
                    bugsAnalysis.call()
                }
            }
        }
        stage('Build and Test') {
            steps {
                script {
                    def golangci = load "${WORKSPACE}/vars/golangci.groovy"
                    golangci.call()
                }
            }
        }
        // Add more stages as needed
    }
}
