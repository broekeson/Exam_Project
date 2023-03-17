# Creates a gcs bucket for terraform state and locks
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.57.0"
    }
  }
}

provider "google" {
  credentials = "${file(var.credentials)}"
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "terraform_state" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true

  versioning {
    enabled = true
  }
}


resource "google_storage_bucket_iam_member" "terraform_state_bucket_iam" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.serviceAccount}"
}

resource "google_storage_bucket_object" "terraform_state_lock" {
  name    = var.object_name
  bucket  = google_storage_bucket.terraform_state.name
  content = ""
}

resource "google_storage_bucket_iam_member" "terraform_state_lock_bucket_iam" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.serviceAccount}"
}
