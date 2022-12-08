pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh './mvnw clean install'
      }
    }

    stage('Run') {
      steps {
        sh 'java -jar target/demo-0.0.1-SNAPSHOT.jar  & echo $! > demo.pid'
      }
    }

    stage('Test') {
      steps {
        warnError(message: 'Ping problem') {
          sh 'curl http://localhost:8080/explorer/index.html'
        }

      }
    }

    stage('Stop') {
      steps {
        sh '''pid=$(cat demo.pid)
kill -9 $pid'''
        dir(path: 'target') {
          archiveArtifacts(artifacts: 'demo-0.0.1-SNAPSHOT.jar', onlyIfSuccessful: true)
        }

      }
    }

  }
  post {
        success {
            writeFile file: 'test.xml', text: '''<?xml version="1.0" encoding="UTF-8"?>
                <testsuites name="Tidy" tests="1" errors="0">
                  <testsuite name="HTML" tests="1" errors="0">
                    <testcase name="HTML tidy" classname="index.html"></testcase>
                  </testsuite>
                </testsuites>'''
            junit 'test.xml'
        }
        always {
            archiveArtifacts artifacts: 'target/demo-0.0.1-SNAPSHOT.jar', fingerprint: true
            emailext to : 'jenkins@bilong.fr',
              attachLog: true,
              subject: "Jenkins - ${currentBuild.fullDisplayName} : ${currentBuild.currentResult}",
              mimeType: 'text/html',
              body: "<p>Info du <a href='${env.BUILD_URL}'>build<a/> : </p> <ul><li>JOB: '${env.JOB_NAME}'</li><li>N° : '${env.BUILD_NUMBER}'</li></ul>"
        }
    }
}
