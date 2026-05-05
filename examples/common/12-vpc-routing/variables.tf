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
  default = "tf-vpc-routing"
}

variable "l2_network_uuid" {
  type = string
}

variable "virtual_router_uuid" {
  type = string
}

variable "subnet_name" {
  type    = string
  default = "tf-vpc-subnet"
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

variable "route_table_name" {
  type    = string
  default = "tf-vpc-route-table"
}

variable "route_destination" {
  type    = string
  default = "0.0.0.0/0"
}

variable "route_target" {
  type        = string
  description = "Route target value expected by ZStack."
}

variable "route_type" {
  type    = string
  default = "UserStatic"
}

variable "route_distance" {
  type    = number
  default = 100
}
