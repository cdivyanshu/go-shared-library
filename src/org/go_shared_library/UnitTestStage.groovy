package org.go_shared_library

class UnitTestStage {
    static void execute(script) {
        // Using the Go Plugin to execute Go commands
        script.sh '''
         go test ./... -v
        '''
    }
}
