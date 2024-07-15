@Library('shared-library') _

pipeline {
    agent any

    environment {
        SONARQUBE_TOKEN = credentials('SONARQUBE_TOKEN') // Replace with your credential ID
    }

    stages {
        stage('git-checkout') {
            steps {
                script {
                    golangci.checkoutgit('https://github.com/OT-MICROSERVICES/employee-api.git')
                }
            }
        }
        stage('static-code-analysis') {
            steps {
                script {
                    golangci.sonarqubecall()
                }
            }
        }
        stage('unit-tests') {
            steps {
                script {
                    golangci.call_unit_testing()
                }
            }
        }
        stage('code-coverage') {
            steps {
                script {
                    golangci.call_coverage()
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
        stage('dast-scanning') {
            steps {
                script {
                    golangci.call_dast_scanning()
                }
            }
        }
        stage('static-code-analysis') {
            steps {
                script {
                    golangci.call_static_code_analysis()
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
}
