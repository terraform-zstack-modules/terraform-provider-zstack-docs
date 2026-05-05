variable "zstack_host" {
  type = string
}

variable "zstack_port" {
  type    = number
  default = 8080
}

variable "zstack_access_key_id" {
  type = string
}

variable "zstack_access_key_secret" {
  type      = string
  sensitive = true
}

variable "public_l3_network_uuid" {
  type        = string
  description = "Public L3 network UUID used to allocate the VIP."
}

variable "vip_name" {
  type    = string
  default = "tf-web-vip"
}

variable "load_balancer_name" {
  type    = string
  default = "tf-web-lb"
}

variable "server_group_name" {
  type    = string
  default = "tf-web-backends"
}

variable "listener_name" {
  type    = string
  default = "tf-web-http"
}

variable "frontend_port" {
  type    = number
  default = 80
}

variable "backend_port" {
  type    = number
  default = 8080
}
