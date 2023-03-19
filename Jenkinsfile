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
                    sh "terraform apply -auto-approve -var 'do_token=${token}'"

                    env.KUBECONFIG = 'kubeconfig.yaml'
                    sh 'kubectl get nodes'
                    }
                  }
                }
            }
        }
        stage('install helm') {
            steps {
                sh 'curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash'
                  }
                }
            }

        stage('iadd nginx repo & install nginx') {
            steps {
                sh 'helm repo add nginx-stable https://helm.nginx.com/stable'
                sh 'helm repo update'
                sh 'helm install nginx nginx-stable/nginx-ingress'
            }
        }
        stage('deploy app') {
            steps {
                sh 'kubectl apply -f 04-kubernetes/01-k8s-sock-app/complete-demo.yaml'
            }
        }
}