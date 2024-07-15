@Library('shared-library') _

pipeline {
    agent any

    tools {
        go 'Go 1.20'
    }

    stages {
        stage('code-compile') {
            steps {
                script {
                    codeCompilation()
                }
            }
        }
        stage('Unit Test') {
            steps {
                script {
                    unitTest()
                }
            }
        }
    }
}
