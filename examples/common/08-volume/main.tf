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

data "zstack_disk_offerings" "data" {
  name = var.disk_offering_name
}

resource "zstack_instance" "vm" {
  name                   = var.vm_name
  description            = "VM with data volume created by Terraform"
  image_uuid             = data.zstack_images.image.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.offering.instance_offers[0].uuid
  expunge                = true

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
      default_l3      = true
    }
  ]
}

resource "zstack_volume" "data" {
  name               = var.data_volume_name
  description        = "Data volume created by Terraform"
  disk_offering_uuid = data.zstack_disk_offerings.data.disk_offers[0].uuid
  vm_instance_uuid   = zstack_instance.vm.uuid
}

output "vm_uuid" {
  description = "Created VM UUID."
  value       = zstack_instance.vm.uuid
}

output "volume_uuid" {
  description = "Created data volume UUID."
  value       = zstack_volume.data.uuid
}
