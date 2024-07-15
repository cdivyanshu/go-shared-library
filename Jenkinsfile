@Library('shared-library') _

node {
    // Define tools and environment variables
    def goTool = tool name: 'Go 1.20', type: 'go'

    try {
        stage('Code Compilation') {
            script {
                callCodeCompilation()
            }
        }
        // Additional stages can be added here
    } finally {
        // Optionally add post-build actions here, e.g., archiving test results
        // junit 'build/test-results/test/*.xml'
    }
}
