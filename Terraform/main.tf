terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.57.0"
    }

    jenkins = {

    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  credentials = var.credentials
}

# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = "false"

  subnetwork_config {
    mode = "CUSTOM"
    secondary_ip_range = [
      {
        range_name    = "alt_pods"
        ip_cidr_range = "10.128.0.0/16"
      },
      {
        range_name    = "alt_services"
        ip_cidr_range = "10.192.0.0/16"
      }
    ]
  }
}

# Create a subnet
resource "google_compute_subnetwork" "alt_subnet" {
  count = 2

  name          = "alt-subnet-${count.index}"
  ip_cidr_range = "10.0.${count.index}.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

# Create a firewall rule to allow internal traffic
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "all"
    source_ranges = [
      google_compute_network.vpc_network.ip_cidr_range
    ]
  }

  source_tags = ["allow all"]
  target_tags = ["allow all"]
}

# Create GKE cluster
resource "google_container_cluster" "primary" {
  name               = "alt-cluster"
  location           = var.region
  initial_node_count = 3

  #Set network config
  network = google_compute_network.vpc_network.self_link
  subnetwork = [
    for subnet in google_compute_subnetwork.alt_subnet : subnet.self_link
  ]

  node_pool {
    name         = "altschool-pool"
    machine_type = "n1-standard-1"
    disk_size_gb = 100
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
  }


  #Set master auth
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = [
        google_compute_network.vpc_network.ip_cidr_range
      ]
    }
  }

   oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

}

resource "google_service_account" "jenkins_service_account" {
  account_id   = "jenkins"
  display_name = "Jenkins Service Account"
}

resource "google_project_iam_binding" "cluster_admin" {
  role = "roles/container.admin"
  members = [
    "serviceAccount:${google_service_account.jenkins_service_account.email}"
  ]
}

resource "google_service_account_key" "jenkins_sa_key" {
  service_account_id = google_service_account.jenkins_service_account.id
}