pipeline {
    agent any
    stages {
        stage('provision cluster') {
            steps {
                script {
                  dir('01-terraform') {
                   withCredentials(string(credentialsId: 'do_token', variable: 'token')) {
                    echo 'creating kubernetes cluster'
                    sh 'terraform init'
                    sh "terraform apply -auto-approve -var 'do_token=$token'"

                    env.KUBECONFIG = 'kubeconfig.yaml'
                    sh 'kubectl get nodes'
                    }
                  }
                }
            }
        }
    }
}