pipeline {
    agent any
    tools {
        maven 'maven'
    }
        stages {
            stage ("scm") {
                script {
                    if (env.branch_name == "master") {
                        steps {
                            checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/vrer2/Sample_Project.git']]])
                        }
                    } else {
                        sh "echo this is not a master branch"
                    }
                }
            }
            stage ("sonar analasys") {
                agent { label "pipeline_slave" }
                environment {
                    scannerHome = tool 'sonarscanner'
                }
                if (env.branch_name == 'master') { 
                    steps {
                        withSonarQubeEnv('sonarqube') {
                            sh "${scannerHome}/bin/sonar-scanner"
                        }
                    }
                } else {
                    sh "echo this is not a master branch"
                }
            }
            stage ("quality gate check") {
                agent { label "pipeline_slave" }
                steps {
                    timeout(time: 2, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
            stage ('maven compile') {
                agent { label "pipeline_slave" }
                steps {
                    sh "mvn compile"
                }
            }
            stage ('maven package') {
                agent { label "pipeline_slave" }
                steps {
                    sh "mvn package"
                }
            }
            stage ('nexus uploader') {
                agent { label "pipeline_slave" }
                steps {
                    nexusArtifactUploader artifacts: [[artifactId: 'simple-web-app', classifier: '', file: 'target/simple-web-app.war', type: 'war']], credentialsId: '3d0359b0-df05-49b2-8217-684d89e11d6f', groupId: 'org.mitre', nexusUrl: '3.94.170.55:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'nexus_relese', version: '2.5'
                }
            }
            stage ('tomcat deploy') {
                agent { label "pipeline_slave" }
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
