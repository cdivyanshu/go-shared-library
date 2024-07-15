package org.go_shared_library

def call() {
    def dependencyCheckHome = tool name: 'Dependency-Check', type: 'org.jenkinsci.plugins.DependencyCheck.tools.DependencyCheckInstallation'
    sh """
        ${dependencyCheckHome}/bin/dependency-check.sh \
        --project employee-api \
        --scan . \
        --format HTML \
        --out dependency-check-report
    """
}
