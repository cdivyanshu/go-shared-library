package org.go_shared_library

class DependencyCheck {
    static void execute(script) {
                // Run Dependency-Check using the defined tool installation
            script.sh '''
                ${DEPENDENCY_CHECK_HOME}/bin/dependency-check.sh --scan . --format HTML --out dependency-check-report.html
            '''
        }
    }
