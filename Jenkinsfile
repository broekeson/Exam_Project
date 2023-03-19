pipeline {
    agent any
    environment {
       DO_TOKEN = credentials('do_token')
       KUBECONFIG = 'kubeconfig.yaml'
    }
    stages {
        stage('provision cluster') {
            steps {
                dir('01-terraform') {
                    sh '''
                    terraform init
                    terraform apply -auto-approve -var DO_TOKEN=${DO_TOKEN}
                    '''
                }
                sh 'kubectl config use-context exam-cluster'
                sh 'kubectl get nodes'
            }
        }
    }
}
