provider "digitalocean" {
  # Configuration options
  token = var.DO_TOKEN
}

data "digitalocean_kubernetes_cluster" "primary" {
  name = var.cluster_name
}


#Access the Load Balancer IP in the kubernetes cluster
data "digitalocean_loadbalancer" "alb" {
  id = data.digitalocean_kubernetes_cluster.primary.node_pool[0].id
}

resource "digitalocean_record" "alb" {
  domain = digitalocean_domain.mydomain.name
  type   = "A"
  name   = var.domain_name
  value  = var.external_ip
  ttl    = 3600
}

resource "digitalocean_record" "sockshop" {
  domain = digitalocean_domain.mydomain.name
  type   = var.record_type
  name   = var.sockshop
  value  = var.domain_name
  ttl    = 3600
}

resource "digitalocean_record" "webapp" {
  domain = digitalocean_domain.mydomain.name
  type   = var.record_type
  name   = var.webapp
  value  = var.domain_name
  ttl    = 3600
}

resource "digitalocean_record" "grafana" {
  domain = digitalocean_domain.mydomain.name
  type   = var.record_type
  name   = var.grafana
  value  = var.domain_name
  ttl    = 3600
}

resource "digitalocean_record" "prometheus" {
  domain = digitalocean_domain.mydomain.name
  type   = var.record_type
  name   = var.prometheus
  value  = var.domain_name
  ttl    = 3600
}



