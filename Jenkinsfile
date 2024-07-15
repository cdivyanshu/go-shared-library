@Library('shared-library') _

pipeline {
    agent any

    tools {
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
