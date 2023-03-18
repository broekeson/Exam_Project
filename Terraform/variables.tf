variable "project" {
  description = "The project ID to deploy to"
  type        = string
  default     = "altschool-project-380908"
}

variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "us-central1"
}

variable "credentials" {
  description = "The credentials to deploy to"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "altschool-vpc"
}