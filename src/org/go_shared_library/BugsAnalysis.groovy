package org.go_shared_library

def call() {
    def scannerHome = tool name: 'Sonar', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
    withSonarQubeEnv('sonar-kumar') {
        sh """
            ${scannerHome}/bin/sonar-scanner \
            -Dsonar.projectKey=shared-lib \
            -Dsonar.sources=. \
            -Dsonar.host.url=http://107.22.112.152:9000/ \
            -Dsonar.login=sqp_fcda13da4f9c8dc0653597115db594d9b52751b0
        """
    }
}
