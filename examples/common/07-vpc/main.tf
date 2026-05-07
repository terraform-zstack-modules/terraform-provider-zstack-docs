terraform {
  required_version = ">= 1.5"

  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.3"
    }
  }
}

provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}

data "zstack_l2networks" "selected" {
  name_pattern = var.l2_network_name_pattern
}

data "zstack_virtual_routers" "selected" {
  name_pattern = var.virtual_router_name_pattern
}

resource "zstack_vpc" "main" {
  name                = var.vpc_name
  description         = "VPC network created by Terraform"
  l2_network_uuid     = data.zstack_l2networks.selected.l2networks[0].uuid
  virtual_router_uuid = data.zstack_virtual_routers.selected.virtual_router[0].uuid
  enable_ipam         = true
  dns                 = var.dns

  subnet_cidr = {
    name         = var.subnet_name
    network_cidr = var.subnet_cidr
    gateway      = var.subnet_gateway
  }
}

output "vpc_uuid" {
  description = "Created VPC UUID."
  value       = zstack_vpc.main.uuid
}

output "selected_l2_network" {
  description = "L2 network selected by the data source."
  value       = data.zstack_l2networks.selected.l2networks[0]
}

output "selected_virtual_router" {
  description = "Virtual router selected by the data source."
  value       = data.zstack_virtual_routers.selected.virtual_router[0]
}
