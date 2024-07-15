// vars/golangci.groovy

package org.go_shared_library

import org.go_shared_library.*

def call() {
    node {
        stage('Bugs Analysis') {
            load "${WORKSPACE}/src/BugsAnalysis.groovy"
        }
        stage('Code Compilation') {
            load "${WORKSPACE}/src/CodeCompilation.groovy"
        }
        stage('Dependency Scanning') {
            load "${WORKSPACE}/src/DependencyScanning.groovy"
        }
        stage('Static Code Analysis') {
            load "${WORKSPACE}/src/StaticCodeAnalysis.groovy"
        }
        stage('Unit Test Stage') {
            load "${WORKSPACE}/src/UnitTestStage.groovy"
        }
    }
}
