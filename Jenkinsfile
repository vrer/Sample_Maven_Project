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
          docker.build("dileep6:dileep6")
        }
      }
    }
    stage ('ecr') {
      steps {
        sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 340043406172.dkr.ecr.us-east-2.amazonaws.com"
        sh "docker tag dileep6:dileep6 340043406172.dkr.ecr.us-east-2.amazonaws.com/dileep:dileep6"
        sh "docker push 340043406172.dkr.ecr.us-east-2.amazonaws.com/dileep:dileep6"
      }
    }
    stage ('deploy to ecs') {
      steps {
        sh "aws ecs update-service --cluster simple-app --service app --force-new-deployment --region us-east-2"
      }
    }
  }
}
