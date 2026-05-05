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

variable "vpc_name" {
  type    = string
  default = "tf-vpc"
}

variable "virtual_router_uuid" {
  type = string
}

variable "subnet_name" {
  type    = string
  default = "tf-private-subnet"
}

variable "l2_network_uuid" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "subnet_gateway" {
  type = string
}

variable "dns" {
  type    = string
  default = "223.5.5.5"
}
