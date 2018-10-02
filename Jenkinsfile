pipeline {
    agent any

    stages {
		
        stage ('Compile Stage') {

            steps {
			dir("/root/.jenkins/workspace/reddy"){
			sh 'mvn clean install'
            }
            }
        }

        
		stage ('Deployment Stage') {

            steps {
                
                    sh 'cp /root/.jenkins/workspace/reddy/target/simple-web-app.war /root/apache-tomcat-8.5.34/webapps '
              
            }
        }


        
    }
}
