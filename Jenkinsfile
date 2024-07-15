@Library('shared-library') _

pipeline {
    agent any

    stages {
       stage('Load Scripts') {
            steps {
                script {
                    def bugsAnalysis = load "${WORKSPACE}/src/BugsAnalysis.groovy"
                    // Use bugsAnalysis in subsequent stages
                }
            }
        }
        stage('Build and Test') {
            steps {
                golangci()
            }
        }
    }
}
