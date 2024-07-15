package org.go_shared_library

def call() {
    sh '''
        go mod tidy
        go mod download
        go build -o employee-api .
    '''
}
