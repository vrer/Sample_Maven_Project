pipeline {
    agent any
    environment {
        BRANCH='develop'
        sonarProjectkey='maven-project'
    }
    stages {
        stage("scm checkout") {
            steps {
                git branch: 'develop', credentialsId: 'github', url: 'https://github.com/vrer/Sample_Maven_Project.git'
            }
        }
        stage ("Sonar Analysis") {
            steps {
                withSonarQubeEnv('sonar_server') {
                    sh "${tool 'sonar_scanner'}/bin/sonar-scanner -Dsonar.projectKey=$sonarProjectkey"
                }
            }
        }
        stage ("maven build") {
            steps {
                sh "mvn clean deploy"
            }
        }
        stage ("Deploy") {
            steps {
                deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'tomcat', path: '', url: 'http://52.211.129.138:8888/')], contextPath: '/test', war: 'target/*.war'
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
    
