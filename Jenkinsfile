@Library('shared-library') _

pipeline {
    agent any
    
    environment {
        SONARQUBE_TOKEN = credentials('SONARQUBE_TOKEN') // Replace with your actual credential ID
    }

    tools {
        // SonarQube Scanner configuration
        sonarqubeScanner 'Sonar' // Use the correct tool type based on Jenkins configuration

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
        stage('dependency-check') {
            steps {
                script {
                    golangci.call_dependency_check()
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
