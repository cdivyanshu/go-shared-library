package org.go_shared_library

import org.go_shared_library.Checkout
import org.go_shared_library.CodeCompilation
import org.go_shared_library.UnitTestStage
import org.go_shared_library.DependencyCheck

def call(Map params) {
    String tasksToRun = params.get('tasks', 'all') // Default to 'all' tasks if not specified

    switch (tasksToRun) {
        case 'checkout':
            checkoutGitRepository(params.gitUrl, params.gitBranch)
            break
        case 'CodeCompilation':
            executeCodeCompilation()
            break
        case 'unitTests':
            runUnitTestStage()
            break
        case 'depenCheck':
            dependencyCheck()
            break
        case 'all':
        default:
            // Run all tasks
          /*  checkoutGitRepository(params.gitUrl, params.gitBranch)
            executeCodeCompilation()
            runUnitTests()
            dependencyCheck()
            break*/
    }
}

def checkoutGitRepository(String gitUrl, String gitBranch) {
    Checkout.execute(this, gitUrl, gitBranch)
}

def executeCodeCompilation() {
    CodeCompilation.execute(this)
}

def runUnitTestStage() {
    UnitTestStage.execute(this)
}
def dependencyCheck() {
    DependencyCheck.execute(this)
}
