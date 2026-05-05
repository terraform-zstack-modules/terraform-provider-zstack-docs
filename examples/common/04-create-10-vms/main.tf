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
  vm_configs = {
    for index in range(var.vm_count) : format("%s-%02d", var.vm_name_prefix, index + 1) => {
      ordinal   = index + 1
      static_ip = try(var.static_ips[index], null)
    }
  }
}

resource "zstack_instance" "vm" {
  for_each = local.vm_configs

  name                   = each.key
  description            = "Batch VM ${each.value.ordinal} created by Terraform"
  image_uuid             = data.zstack_images.image.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.offering.instance_offers[0].uuid
  expunge                = true

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
      default_l3      = true
      static_ip       = each.value.static_ip
    }
  ]
}

output "vm_uuids" {
  description = "Created VM UUIDs keyed by VM name."
  value       = { for name, vm in zstack_instance.vm : name => vm.uuid }
}

output "vm_nics" {
  description = "Created VM NICs keyed by VM name."
  value       = { for name, vm in zstack_instance.vm : name => vm.vm_nics }
}
