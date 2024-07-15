// vars/golangci.groovy
import org.go_shared_library.CodeCompilation

def callCodeCompilation() {
    new CodeCompilation().call()
}

def call() {
    callCodeCompilation()
}
