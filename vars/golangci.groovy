import org.go_shared_library.BugsAnalysis
import org.go_shared_library.CodeCompilation
import org.go_shared_library.DependencyScanning
import org.go_shared_library.StaticCodeAnalysis
import org.go_shared_library.UnitTestStage

def checkoutgit(String gitUrl, String branch = 'main') {
    git url: gitUrl, branch: branch
}

def sonarqubecall() {
    new BugsAnalysis().call()
}

def call_unit_testing() {
    new UnitTestStage().call()
}

def call_coverage() {
    new CodeCoverage().call()
}

def calldependency() {
    new DependencyScanning().call()
}

def call_dast_scanning() {
    new DASTScanning().call()
}

def call_static_code_analysis() {
    new StaticCodeAnalysis().call()
}

def call_compilation() {
    new CodeCompilation().call()
}
