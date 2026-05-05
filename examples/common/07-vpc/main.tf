terraform {
  required_version = ">= 1.5"

  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.2"
    }
  }
}

provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}

resource "zstack_vpc" "main" {
  name                = var.vpc_name
  description         = "VPC network created by Terraform"
  l2_network_uuid     = var.l2_network_uuid
  virtual_router_uuid = var.virtual_router_uuid
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
