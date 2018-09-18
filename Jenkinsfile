pipeline {
    agent any

    stages {
		
		stage ('Checkout Stage') {

            steps {
					sh 'rm -rf Mavendemo'
                    sh 'git clone https://github.com/kasiviswa456/Mavendemo.git'
                
            }
        }
        stage ('Compile Stage') {

            steps {
			dir("/root/.jenkins/workspace/Pipeline/Mavendemo"){
			sh 'mvn clean install'
            }
            }
        }

        
		stage ('Deployment Stage') {

            steps {
                
                    sh 'cp /root/.jenkins/workspace/pipeline/Mavendemo/target/maven-1.0.0.war /root/tomcat/apache-tomcat-9.0.10/webapps/'
              
            }
        }


        
    }
}