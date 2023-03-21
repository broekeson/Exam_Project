pipeline {
    agent any
    environment {
       DO_TOKEN = credentials('do_token')
       KUBECONFIG = '/var/lib/jenkins/workspace/provisioning_cluster/01-terraform/kubeconfig.yaml'
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

         stage('heml setup') {
            steps {
                sh '''
                curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
                helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
                helm repo update
                helm install nginx-ingress ingress-nginx/ingress-nginx
                '''
            }
        }
         stage('Install cert-manager') {
            steps {
                sh '''
                kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml
                helm repo add jetstack https://charts.jetstack.io
                helm repo update
                kubeclt create namespace cert-manager
                helm install cert-manager --namespace cert-manager --version v1.11.0 jetstack/cert-manager
                '''
            } 
      }
    }

    post {
       success {
        build 'deploy'
       }
    }
}
