terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.26.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.5.0"
    }
  }
}