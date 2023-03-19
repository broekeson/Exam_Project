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
             }
         }
        stage('Install helm') {
            steps {
             sh 'curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash'
            }
         }
        stage('add helm repo and install nginx-ingress') {
          steps {
            sh 'helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx'
            sh 'helm repo update'
            sh 'helm install nginx-ingress ingress-nginx/ingress-nginx'
           }
          }
     }
}
