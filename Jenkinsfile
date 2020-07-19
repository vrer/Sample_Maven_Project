pipeline {
  agent any 
  stages {
    stage ("SCM_CHECKOUT") {
      steps {
            git branch: 'master', url: 'https://github.com/vrer2/Sample_Project.git'
      }
    }
    stage ("scan") {
      environment {
        scannerHome = tool 'sonarscanner'
      }
        steps {
          withSonarQubeEnv('sonarqube') {
            sh "${scannerHome}/bin/sonar-scanner"
          }
        }
    }
    stage ("quality") {
      steps {
        timeout(time: 05, unit: 'MINUTES') {
          waitForQualityGate abortPipeline: true
        }
      }
    }
    stage ('maven') {
      steps { 
        sh 'mvn clean install'
      }
    }
    stage ('docker') {
      steps { 
        script {
          docker.build("dileep5:dileep5")
        }
      }
    }
  }
}
