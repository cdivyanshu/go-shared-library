def call() {
    sh '''
        go mod tidy
        go mod download
        go build -o employee-api .
    '''
}
