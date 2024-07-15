@Library('shared-library') _

pipeline {
    agent any

    environment {
        SONARQUBE_TOKEN = credentials('SONARQUBE_TOKEN') // Use the credential ID here
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
    }
/*        stage('static-code-analysis') {  // Rename this stage if needed
            steps {
                script {
                    golangci.sonarqubecall()
                }
            }
        } */
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
