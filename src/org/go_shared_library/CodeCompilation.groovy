package org.go_shared_library

class CodeCompilation {
    static void execute(script) {
        // Using the Go Plugin to execute Code Compilation
        script.sh '''
            go mod tidy
            go mod download
            go build -o employee-api .
        '''
    }
}
