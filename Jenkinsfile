@Library('shared-library') _

pipeline {
    agent any

    tools {
        // Define the Go tool installation
        go 'Go'
        // 'Go' here is the name of the Go installation configured in Jenkins
    }
    environment {
        DEPENDENCY_CHECK_HOME = tool 'Dependency-Check' // Define DEPENDENCY_CHECK_HOME for Dependency-Check
    }

    parameters {
        string(name: 'gitUrl', defaultValue: 'https://github.com/Naresh-boyini/employee-api.git', description: 'Git repository URL')
        string(name: 'gitBranch', defaultValue: 'main', description: 'Git branch')
        string(name: 'tasks', defaultValue: 'all', description: 'Tasks to execute: checkout, goCommands, unitTests, depenCheck or all')
    }

    stages {
        stage('Execute Pipeline') {
            steps {
                script {
                    golangci(
                        gitUrl: params.gitUrl,
                        gitBranch: params.gitBranch,
                        tasks: params.tasks
                    )
                }
            }
        }
    }
}
