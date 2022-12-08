pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh './mvnw clean install'
      }
    }

    stage('Run') {
      parallel {
        stage('Run') {
          steps {
            sh 'java -jar target/demo-0.0.1-SNAPSHOT.jar  & echo $! > demo.pi'
          }
        }

        stage('ping') {
          steps {
            sh 'ping http://141.95.165.43/'
          }
        }

      }
    }

  }
}