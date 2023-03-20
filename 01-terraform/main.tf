provider "digitalocean" {
  # Configuration options
  token = "${var.DO_TOKEN}"
}

# Create a VPC network
resource "digitalocean_vpc" "altschool_vpc" {
  name = var.vpc
  region = var.region
  ip_range = var.cidr_block
}

# Create a kubernetes cluster
resource "digitalocean_kubernetes_cluster" "altschool_cluster" {
  name = var.cluster_name
  region = var.region
  version = var.version_name
  vpc_uuid = digitalocean_vpc.altschool_vpc.id
  node_pool {
    name = var.worker_name
    size = "s-2vcpu-2gb-intel"
    node_count = 4
    auto_scale = true
    min_nodes = 3
    max_nodes = 8
    tags = [ "workers" ]
  }
}

