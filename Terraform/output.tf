output "kubeconfig" {
  value     = google_container_cluster.primary.kubeconfig[0].raw_config
  sensitive = true
}