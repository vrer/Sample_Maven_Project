pipeline {
    agent any
    tools {
        maven 'maven'
    }
        stages {
            stage ("scm") {
                steps {
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/vrer2/Sample_Project.git']]])
                    }
            }
        stage ("sonar analasys") {
            environment {
                scannerHome = tool 'sonarscanner'
            }
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage ("quality gate check") {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage ('maven compile') {
            steps {
                sh "mvn compile"
            }
        }
        stage ('maven package') {
            steps {
                sh "mvn package"
            }
        }
        stage ('nexus uploader') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'simple-web-app', classifier: '', file: 'target/simple-web-app.war', type: 'war']], credentialsId: '3d0359b0-df05-49b2-8217-684d89e11d6f', groupId: 'org.mitre', nexusUrl: '3.94.170.55:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'nexus_relese', version: '2.7'
            }
        }
        stage ('tomcat deploy') {
            steps {
                sh "sudo cp target/*war /opt/apache-tomcat-8.5.51/webapps"
            }
        }
    }
    post {
    success {
        emailext (
            to: 'naramreddydileepreddy@gmail.com',
            subject: "JOB: ${env.JOB_NAME} - SUCCESS",
            body: "JOB SUCCESS - \"${env.JOB_NAME}\" Build No: ${env.BUILD_NUMBER}\n\nClick on the below link to view the logs:\n ${env.BUILD_URL}\n"
        )
    }
    failure {
		emailext (
            to: 'naramreddydileepreddy@gmail.com',
            subject: "JOB: ${env.JOB_NAME} - FAILURE",
            body: "JOB FAILURE - \"${env.JOB_NAME}\" Build No: ${env.BUILD_NUMBER}\n\nClick on the below link to view the logs:\n ${env.BUILD_URL}\n"
        )
    }
    }
}
