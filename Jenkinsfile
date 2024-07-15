pipeline {
    agent any
    
    stages {
        stage('Code Compilation') {
            steps {
                script {
                    def codeCompilation = load "${WORKSPACE}/src/CodeCompilation.groovy"
                    codeCompilation.call()
                }
            }
        }
        stage('Unit Testing') {
            steps {
                script {
                    def unitTestStage = load "${WORKSPACE}/src/UnitTestStage.groovy"
                    unitTestStage.call()
                }
            }
        }
    }
}
