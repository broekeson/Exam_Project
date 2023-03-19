pipeline {
    agent any
    environment {
       DO_TOKEN = credentials('do_token')
    }
    stages {
        stage('provision cluster') {
            steps {
                script {
                  dir('01-terraform') {
                    sh '''
                    export TF_API_TOKEN=$TF_API_TOKEN
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
}