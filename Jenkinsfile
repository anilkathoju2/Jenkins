pipeline {
  agent {
    docker { image 'node:16-alpine' }
  }
  stages {
    stage('test') {
      steps {
        sh 'node --version'
      }
    stage('Build') {
            steps {
                sh 'docker build -t my-node-app:latest .'
            }
        }
     stage('Run') {
            steps {
                sh '''
                  docker rm -f my-node-app || true
                  docker run -d --name my-node-app -p 3000:3000 my-node-app:latest
                '''
            }
      }
    }
  }
}