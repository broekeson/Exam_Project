variable "DO_TOKEN" {}

variable "nginx_ip" {}

variable "cluster_name" {
  type    = string
  default = "altschool-cluster"
}

variable "mydomain" {
  type    = string
  default = "ekene.tech"
}

variable "record_type" {
  type    = string
  default = "A"
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
