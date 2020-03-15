pipeline {
    agent any
    tools {
        maven 'maven'
    }
        stages {
            stage ("scm") {
                steps {
                    script {
                        if (env.branch_name == "master") {
                            checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/vrer2/Sample_Project.git']]])
                        } else {
                            sh "echo this is not a master branch"
                        }
                    }
                }
            }
            stage ("sonar analasys") {
                environment {
                    scannerHome = tool 'sonarscanner'
                }
                steps {
                    script {
                        if (env.branch_name == 'master') { 
                            withSonarQubeEnv('sonarqube') {
                                sh "${scannerHome}/bin/sonar-scanner"
                            }
                        } else { 
                            sh "echo this is not a master branch"
                        }
                    }
                }
            }
            stage ("quality gate check") { 
                steps {
                    script {
                        if (env.branch_name == 'master') {
                            timeout(time: 2, unit: 'MINUTES') {
                                waitForQualityGate abortPipeline: true
                            }
                        } else {
                            sh "echo this is not a master branch"
                        }
                    }
                }
            }
            stage ('maven compile') {
                steps {
                    script {
                        if (env.branch_name == 'master') {
                            sh "mvn compile"
                        } else {
                            sh "echo this is not a master branch"
                        }
                    }
                }
            }
            stage ('maven package') {
                steps {
                    sh "mvn package"
                }
            }
            stage ('nexus uploader') {
                steps {
                    script {
                        if (env.branch_name == 'master') {
                            nexusArtifactUploader artifacts: [[artifactId: 'simple-web-app', classifier: '', file: 'target/simple-web-app.war', type: 'war']], credentialsId: '3d0359b0-df05-49b2-8217-684d89e11d6f', groupId: 'org.mitre', nexusUrl: '3.94.170.55:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'nexus_relese', version: '7.6'
                        } else {
                            sh "echo this is not a master branch"
                            
                        }
                    }
                }
            }
            stage ('tomcat deploy') {
                steps {
                    script {
                        if (env.branch_name == 'master') {
                            sh "sudo cp target/*war /opt/apache-tomcat-8.5.51/webapps"
                        } else {
                            sh "echo this is not a master branch"
                        }
                    }
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
