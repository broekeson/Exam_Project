output "kubeconfig" {
  value = digitalocean_kubernetes_cluster.altschool_cluster.kube_config[0].raw_config
  sensitive = true
}

resource "local_file" "kubeconfig" {
  content = digitalocean_kubernetes_cluster.altschool_cluster.kube_config[0].raw_config
  filename = "kubeconfig.yaml"
  file_permission = "400"
}