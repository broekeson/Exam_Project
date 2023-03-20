provider "digitalocean" {
  # Configuration options
  token = var.DO_TOKEN
}

data "digitalocean_kubernetes_cluster" "primary" {
  name = var.cluster_name
}

data "digitalocean_loadbalancer" "alb" {
  name = data.digitalocean_kubernetes_cluster.primary.load_balancers_name
}

resource "digitalocean_domain" "mydomain" {
  name  = var.domain_name
}

resource "digitalocean_record" "alb" {
  domain = digitalocean_domain.mydomain.name
  type   = "A"
  name   = var.domain_name
  value  = data.digitalocean_loadbalancer.alb.ip
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



