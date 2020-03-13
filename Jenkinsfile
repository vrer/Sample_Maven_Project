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
                nexusPublisher nexusInstanceId: 'nexus', nexusRepositoryId: 'nexus_relese', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'target/*.war']], mavenCoordinate: [artifactId: 'simple-web-app', groupId: 'org.mitre', packaging: 'war', version: '5.6']]]
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
