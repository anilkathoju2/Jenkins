pipeline {
  agent {
    docker { image 'node:16-alpine' }
  }
  stages {
    stage('Test') {
      steps {
        sh 'node --version'
      }
      stage('build') {
        steps {
           sh 'docker build -t my-node:latest '
        }
        stage('run') {
            steps {
                sh 'docker run -d --name my-node-app -p 3000:3000 my-node-app:latest'
            }
        }
      }
    }
  }
}