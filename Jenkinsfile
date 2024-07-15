@Library('shared-library') _

node {
    def goTool = tool name: 'Go 1.20', type: 'go'

    try {
        stage('Code Compilation') {
            script {
                golangci.callCodeCompilation()
            }
        }
        // Additional stages can be added here
    } finally {
        // Optionally add post-build actions here
    }
}
