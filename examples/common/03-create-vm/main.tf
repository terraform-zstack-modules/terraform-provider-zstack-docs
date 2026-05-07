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

data "zstack_images" "image" {
  name = var.image_name
}

data "zstack_l3networks" "network" {
  name = var.l3_network_name
}

data "zstack_instance_offerings" "offering" {
  name = var.instance_offering_name
}

locals {
  image_uuid             = data.zstack_images.image.images[0].uuid
  l3_network_uuid        = data.zstack_l3networks.network.l3networks[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.offering.instance_offers[0].uuid
}

resource "zstack_instance" "vm" {
  name                   = var.vm_name
  description            = "Created by Terraform"
  image_uuid             = local.image_uuid
  instance_offering_uuid = local.instance_offering_uuid
  expunge                = true
  never_stop             = var.never_stop

  network_interfaces = [
    {
      l3_network_uuid = local.l3_network_uuid
      default_l3      = true
      static_ip       = var.static_ip
    }
  ]
}

output "vm_uuid" {
  description = "Created VM UUID."
  value       = zstack_instance.vm.uuid
}

output "vm_name" {
  description = "Created VM name."
  value       = zstack_instance.vm.name
}

output "vm_nics" {
  description = "VM NICs reported by ZStack."
  value       = zstack_instance.vm.vm_nics
}
