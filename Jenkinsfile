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
            sh 'helm repo add stable https://kubernetes-charts.storage.googleapis.com/'
            sh 'helm repo update'
            sh 'helm install nginx-ingress stable/nginx-ingress --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux'
           }
          }
     }
}
