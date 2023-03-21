variable "DO_TOKEN" {}

variable "nginx_ip" {
  type    = string
  default = "46.101.66.166"
}

variable "cluster_name" {
  type    = string
  default = "altschool-cluster"
}

variable "mydomain" {
  type    = string
  default = "abtl.ng"
}


variable "domain_name" {
  type    = string
  default = "abtl.ng."
}

variable "record_type" {
  type    = string
  default = "CNAME"
}

variable "sockshop" {
  type    = string
  default = "sock-shop"
}

variable "webapp" {
  type    = string
  default = "web-app"
}

variable "grafana" {
  type    = string
  default = "grafana"
}

variable "prometheus" {
  type    = string
  default = "prometheus"
}

variable "worker_name" {
  type    = string
  default = "altschool-pool"
}
