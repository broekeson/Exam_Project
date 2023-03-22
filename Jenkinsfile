pipeline {
    agent any
    environment {
       DO_TOKEN = credentials('do_token')
       KUBECONFIG = '/var/lib/jenkins/workspace/provisioning_cluster/01-terraform/kubeconfig.yaml'
       SERVICE = 'nginx-ingress-ingress-nginx-controller'
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
        stage('heml & nginx-ingress setup') {
            steps {
                sh '''
                curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
                helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
                helm repo update
                helm install nginx-ingress ingress-nginx/ingress-nginx
                '''
            }
        }
        stage('Sleep for 30 seconds') {
            steps {
                sleep time: 30, unit: 'SECONDS'
            }
        }
        stage('Installing cert-manager') {
            steps {
                sh '''
                kubectl create namespace cert-manager
                helm repo add jetstack https://charts.jetstack.io
                helm repo update
                kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml
                helm install cert-manager --namespace cert-manager --version v1.11.0 jetstack/cert-manager
                '''
            }
        }
        stage('Installing Prometheus') {
            steps {
                sh '''
                kubectl create namespace monitoring
                helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
                helm repo update
                helm install prometheus --namespace monitoring prometheus-community/prometheus
                '''
            }
        }
        stage('Install elastic-stack') {
            steps {
                sh '''
                kubectl create namespace logging
                helm repo add elastic https://helm.elastic.co
                helm repo update
                helm install elasticsearch --namespace logging elastic/elasticsearch
                helm install kibana --namespace logging elastic/kibana
                '''
            }
        }
        stage('Sleep for 15 seconds') {
            steps {
                sleep time: 15, unit: 'SECONDS'
            }
        }
        stage('deploy-web-app') {
            steps {
                dir('04-kubernetes') {
                sh '''
                kubectl apply -f 02-k8s-web-app/a-namespace.yaml
                kubectl apply -f 02-k8s-web-app/secret.yaml
                kubectl apply -f 02-k8s-web-app/configMap.yaml
                kubectl apply -f 02-k8s-web-app/db-deployment.yaml
                kubectl apply -f 02-k8s-web-app/db-service.yaml
                kubectl apply -f 02-k8s-web-app/web-app-deployment.yaml
                kubectl apply -f 02-k8s-web-app/web-app-service.yaml
                '''
                }
            }
        }
        stage('deploy-sock-shop') {
            steps {
                dir('04-kubernetes') {
                sh '''
                kubectl apply -f 01-k8s-sock-app/complete-demo.yaml
                kubectl apply -f 01-k8s-sock-app/manifests-monitoring/
                kubectl apply -f 01-k8s-sock-app/manifests-alerting/
                '''
              }
          }
        }
        stage('Create ClusterIssuer & Ingress Rules') {
          steps {
              dir('04-kubernetes') {
              sh '''
              kubectl apply -f ingress-controller/cluster-issuer.yaml
              kubectl apply -f ingress-controller/monitoring.yaml
              kubectl apply -f ingress-controller/sock-shop-ingress.yaml
              kubectl apply -f ingress-controller/web-app-ingress.yaml
              '''
                }
            }
        }
        stage('Get External IP') {
          steps {
            dir('05-terraform/terraform') {
            script {
              sh '''
              LOAD_BALANCER_IP=$(kubectl get svc $SERVICE -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
              terraform init
              terraform apply  -var DO_TOKEN=${DO_TOKEN} -var nginx_ip=$LOAD_BALANCER_IP -auto-approve
              '''
            }  
          }
         }
        }
    }
}
