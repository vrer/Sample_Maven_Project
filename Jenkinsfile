pipeline {
    agent any
    stages {	
        stage ('Build Stage') {
            steps {
			dir("/var/lib/jenkins/workspace/deploy/"){
			def mvnHome = tool name: 'mvn', type: 'maven'
			sh 'mvn clean install'
            }
            }
        }
		stage ('Deployment Stage') {
            steps {
                
                    sh 'cp /var/lib/jenkins/workspace/deploy/target/.war /opt/tomcat/apache-tomcat-8.5.37/webapps/'
            }
        }
    }
}
