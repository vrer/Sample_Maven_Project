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
        stage ("parallel stage") {
            parallel {
                stage ("test1") {
                    steps {
                        echo "test1"
                    }
                }
                stage ("test2") {
                    steps {
                        echo "test2"
                    }
                }
                stage ("test3") {
                    steps {
                        echo "test3"
                    }
                }            
            }
        }
    }
}
    
