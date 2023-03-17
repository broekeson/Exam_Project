variable "project" {
  description = "The project ID to manage the Cloud Storage bucket"
  type        = string
  default     = "altschool-project-380908"
}

variable "region" {
  description = "The region to manage the Cloud Storage bucket"
  type        = string
  default     = "us-central1"
}

variable "credentials" {
  description = "The credentials to manage the Cloud Storage bucket"
  type        = string
}

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket"
  type        = string
  default     = "altschool-state-bucket"
}

variable "serviceAccount" {
  description = "The service account to manage the Cloud Storage bucket"
  type        = string
  default     = "broekeson@altschool-project-380908.iam.gserviceaccount.com"
}