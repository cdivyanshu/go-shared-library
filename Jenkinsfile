
@Library('shared-library') _

pipeline {
    agent any

    tools {
        go 'Go 1.20'
    }
    environment {
        DEPENDENCY_CHECK_HOME = tool 'Dependency-Check' // Define DEPENDENCY_CHECK_HOME for Dependency-Check
    }

    stages {
        stage('code-compile') {
            steps {
                codeCompilation()
            }
        }
        stage('Unit Test') {
            steps {
                unitTest()
            }
        }
        stage('Dependency Scanning') {
            steps {
                dependencyScanning()
            }
        }
        stage('Bugs Analysis') {
            steps {
                bugsAnalysis()
            }
        }
    }
}
