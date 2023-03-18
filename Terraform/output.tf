output "kubeconfig" {
  value = google_container_cluster.primary.master_auth.0.client_certificate_config.0.client_certificate
}