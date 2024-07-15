package org.go_shared_library

class Checkout {
    static void execute(script, String gitUrl, String gitBranch) {
        script.checkout([
            $class: 'GitSCM',
            branches: [[name: gitBranch]],
            userRemoteConfigs: [[url: gitUrl]]
        ])
    }
}
