pipeline {
    agent any
    environment {
        TF_API_TOKEN = ""
    }
    stages {
        stage('provision cluster') {
            steps {
                script {
                  dir('01-terraform') {
                   withCredentials(string(credentialsId: 'do_token', variable: 'TF_API_TOKEN')) {
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
}