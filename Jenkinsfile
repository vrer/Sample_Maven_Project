pipeline {
    agent any
    
    stages {
        stage ('build') {
           steps {
               sh 'mvn clean install'
           }
        }	
        stage ('deploy') {
            steps {
                sh 'cp /root/.jenkins/workspace/sample/target/*.war /opt/tomcat/webapps'
            }
        }

    }
}
