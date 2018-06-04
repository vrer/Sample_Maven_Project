pipeline {
  agent none
  stages {
    stage('Maven Install') {
      agent {
        docker {
          image 'docker.io/maven'
        }
      }
      steps {
        sh 'mvn clean install'
      }
    } 
  }
}
