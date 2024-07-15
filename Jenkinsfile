@Library('shared-library') _

pipeline {
    agent any

    stages {
        stage('Build and Test') {
            steps {
                golangci()
            }
        }
    }
}
