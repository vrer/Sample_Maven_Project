pipeline {
    agent any
    stages {
        stage ("scm") {
            steps {
                sh "echo helo world"
            }
        }
        stage ("test") {
            steps {
                sh "touch testing"
            }
        }
        stage ("test2") {
            steps {
                sh "export"
            }
        }
    }
}
