// src/org/go_shared_library/CodeCompilation.groovy
package org.go_shared_library

class CodeCompilation {
    def call() {
        println 'Code compilation logic goes here'
        // Add your code compilation logic here
    }
}
/*


def call() {
    sh '''
        go mod tidy
        go mod download
        go build -o employee-api .
    '''
}
*/
