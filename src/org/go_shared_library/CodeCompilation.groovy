// src/org/go_shared_library/CodeCompilation.groovy
package org.go_shared_library

import hudson.model.*
import jenkins.model.*
import org.jenkinsci.plugins.workflow.cps.CpsScript

class CodeCompilation implements Serializable {
    def script

    CodeCompilation(CpsScript script) {
        this.script = script
    }

    def call() {
        script.println 'Code compilation logic goes here'
        script.sh '''
            go mod tidy
            go mod download
            go build -o employee-api .
        '''
    }
}
