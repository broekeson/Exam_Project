variable "vpc" {
  type = string
  default = "altschool-vpc"
}

variable "DO_TOKEN" {}

variable "region" {
  type = string
  default = "lon1"
}

variable "cidr_block" {
  type = string
  default = "192.168.1.0/24"
}

variable "cluster_name" {
  type = string
  default = "altschool-cluster"
}

variable "version_name" {
  type = string
  default = "1.25.4-do.0"
}
  

variable "worker_name" {
  type = string
  default = "altschool-pool"
}

variable "size" {
  type = string
  default = "s-2vcpu-4gb"
}