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
            mail(subject: 'Test', body: 'Test jenkins', to: 'j.bilong@gmail.com', mimeType: 'text', from: 'j.bilong@gmail.com')
            sh 'ping http://141.95.165.43/'
          }
        }

      }
    }

  }
}