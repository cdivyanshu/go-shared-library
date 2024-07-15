// vars/golangci.groovy

package org.go_shared_library

import org.go_shared_library.*

def call() {
    node {
        stage('Bugs Analysis') {
            load 'src/BugsAnalysis.groovy'
        }
        stage('Code Compilation') {
            load 'src/CodeCompilation.groovy'
        }
        stage('Dependency Scanning') {
            load 'src/DependencyScanning.groovy'
        }
        stage('Static Code Analysis') {
            load 'src/StaticCodeAnalysis.groovy'
        }
        stage('Unit Test Stage') {
            load 'src/UnitTestStage.groovy'
        }
    }
}
