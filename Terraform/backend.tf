terraform {
  backend "gcs" {
    bucket = "altschool-state-bucket"
    prefix = "terraform/state"
  }
}