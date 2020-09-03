pipeline {
   agent {
      label 'slave'
   }

   stages {
      stage('Git clone') {
        steps {
          echo 'Cloning github repo...'
          git 'https://github.com/PeterYordanov/DevOpsHomework.git'
        }
      }
      stage('Docker build') {
       steps {
          echo 'Building docker image'
          sh 'docker image build -t devops-container .'
       }
     }
     stage('Docker push') {
       steps {
         echo 'Pushing to repository'
         sh 'docker login docker.io -u peteryordanov -p *************'
         sh 'docker tag devops-container peteryordanov/devopshomework'
         sh 'docker push peteryordanov/devopshomework'
       }
     }
     stage('Docker run') {
       steps {
         echo 'Running docker container'
         sh 'docker container run -t devops-container -d'
       }
     }
   }
}
