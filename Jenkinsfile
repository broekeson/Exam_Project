pipeline {
    agent any
    environment {
       DO_TOKEN = credentials('do_token')
    }
    stages {
        stage('provision cluster') {
            steps {
                  dir('01-terraform') {
                    sh '''
                    terraform init
                    terraform plan
                    terraform apply -auto-approve
                    '''

                    env.KUBECONFIG = 'kubeconfig.yaml'
                    sh 'kubectl get nodes'
                  }
                }
            }
        }
   }