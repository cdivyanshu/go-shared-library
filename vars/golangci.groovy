// vars/golangci.groovy

package org.go_shared_library

import org.go_shared_library.*

def call() {
    node {
        stage('Bugs Analysis') {
            bugsAnalysis()
        }
        stage('Code Compilation') {
            codeCompilation()
        }
        stage('Dependency Scanning') {
            dependencyScanning()
        }
        stage('Static Code Analysis') {
            staticCodeAnalysis()
        }
        stage('Unit Test Stage') {
            unitTestStage()
        }
    }
}

def bugsAnalysis() {
    load 'src/BugsAnalysis.groovy'
}

def codeCompilation() {
    load 'src/CodeCompilation.groovy'
}

def dependencyScanning() {
    load 'src/DependencyScanning.groovy'
}

def staticCodeAnalysis() {
    load 'src/StaticCodeAnalysis.groovy'
}

def unitTestStage() {
    load 'src/UnitTestStage.groovy'
}
