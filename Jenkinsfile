pipeline {
    agent any
     stage('scm checkout'){
       git 'https://github.com/vrer2/Sample_Project.git'
     
     }
     stage('mvn package'){
          def mvnHome = tool name: 'mvn', type: 'maven' 
          sh '${mvnHome}/bin/mvn clean install'
          }
     stage('deploying war file into tomcat'){
         cp '/var/lib/jenkins/workspace/deploy/target/*.war /opt/tomcat/apache-tomcat-8.5.37/webapps/'

     }          
    }     
     
