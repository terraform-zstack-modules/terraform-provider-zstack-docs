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

resource "zstack_instance" "vm" {
  name                   = var.vm_name
  description            = "VM protected by a Terraform-managed security group"
  image_uuid             = data.zstack_images.image.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.offering.instance_offers[0].uuid
  expunge                = true

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
      default_l3      = true
      static_ip       = var.static_ip
    }
  ]
}

resource "zstack_networking_secgroup" "web" {
  name         = var.security_group_name
  description  = "Web access managed by Terraform"
  vswitch_type = var.vswitch_type
  ip_version   = 4
}

resource "zstack_networking_secgroup_rule" "ingress" {
  for_each = var.ingress_rules

  name                    = each.key
  security_group_uuid     = zstack_networking_secgroup.web.uuid
  direction               = "Ingress"
  action                  = "ACCEPT"
  protocol                = each.value.protocol
  priority                = each.value.priority
  ip_version              = 4
  ip_ranges               = each.value.ip_ranges
  destination_port_ranges = each.value.destination_port_ranges
  description             = each.value.description
  state                   = "Enabled"
}

resource "zstack_networking_secgroup_attachment" "vm_nic" {
  secgroup_uuid = zstack_networking_secgroup.web.uuid
  nic_uuid      = zstack_instance.vm.vm_nics[0].uuid
}

output "vm_uuid" {
  description = "Created VM UUID."
  value       = zstack_instance.vm.uuid
}

output "security_group_uuid" {
  description = "Created security group UUID."
  value       = zstack_networking_secgroup.web.uuid
}
