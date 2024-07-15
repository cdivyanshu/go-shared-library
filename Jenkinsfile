@Library('shared-library') _

pipeline {
    agent any

    tools {
        // Dependency-Check configuration
        dependencyCheck name: 'Dependency-Check'

        // Go configuration
        go 'Go 1.20'
    }

    stages {
        stage('git-checkout') {
            steps {
                script {
                    golangci.checkoutgit('https://github.com/OT-MICROSERVICES/employee-api.git')
                }
            }
        }
        stage('code-compilation') {
            steps {
                script {
                    golangci.call_compilation()
                }
            }
        }
        /* Uncomment or adjust as needed
        stage('static-code-analysis') {
            steps {
                script {
                    golangci.sonarqubecall()
                }
            }
        }
        */
        stage('unit-tests') {
            steps {
                script {
                    golangci.call_unit_testing()
                }
            }
        }
        stage('dependency-scanning') {
            steps {
                script {
                    golangci.calldependency()
                }
            }
        }
    }

    post {
        always {
            script {
                deleteDir()
            }
        }
    }
}
