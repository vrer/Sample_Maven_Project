pipeline {
    agent any
    environment {
        BRANCH='develop'
        sonarProjectkey='maven-project'
    }
    stages {
        stage("scm checkout") {
            steps {
                sh 'export'
            }
        }
        stage ("Sonar Analysis") {
            steps {
                echo "Hello World"
            }
        }
        stage ("maven build") {
            steps {
                echo "Hello World from maven"
            }
        }        
    }
}
