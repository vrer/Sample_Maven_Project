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
        stage('Quality Gate Check') {
            steps {
                timeout(time: 1, unit: 'MINUTES') { 
                    waitForQualityGate abortPipeline: true
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
    post {
        success {
            cleanWs()
            emailext(
                subject: "✅ SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                body: """<p>Good news!</p>
                         <p>The job <b>${env.JOB_NAME}</b> build <b>${env.BUILD_NUMBER}</b> has <b style='color:green;'>succeeded</b>.</p>
                         <p>Check details: <a href='${env.BUILD_URL}'>Build Log</a></p>""",
                to: "reddyeswar.sre@gmail.com"
            )
        }

        failure {
            emailext(
                subject: "❌ FAILURE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                body: """<p>Unfortunately,</p>
                         <p>The job <b>${env.JOB_NAME}</b> build <b>${env.BUILD_NUMBER}</b> has <b style='color:red;'>failed</b>.</p>
                         <p>Check logs here: <a href='${env.BUILD_URL}'>Build Log</a></p>""",
                to: "reddyeswar.sre@gmail.com"
            )
        }
        always {
            echo "Alwayssssssssssss"
        }
    }
}
