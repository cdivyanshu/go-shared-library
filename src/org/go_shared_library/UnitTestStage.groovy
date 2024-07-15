package org.go_shared_library

def call() {
    sh 'go test -v ./...'
}
