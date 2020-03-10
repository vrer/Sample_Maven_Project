pipeline {
    agent any
    stages {
        stage ("scm") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/vrer2/Sample_Project.git']]])
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
