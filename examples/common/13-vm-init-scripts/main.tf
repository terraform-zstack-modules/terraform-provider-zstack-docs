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

resource "zstack_ssh_key_pair" "admin" {
  name        = var.ssh_key_name
  description = "SSH key imported by Terraform"
  public_key  = var.ssh_public_key
}

resource "zstack_instance" "vm" {
  name                   = var.vm_name
  description            = "VM initialized by Terraform-managed script"
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

resource "zstack_instance_scripts" "bootstrap" {
  name           = var.script_name
  description    = "Bootstrap script managed by Terraform"
  script_content = var.script_content
  platform       = "Linux"
  script_type    = "Shell"
  script_timeout = var.script_timeout
  encoding_type  = "PlainText"
}

resource "zstack_instance_scripts_execution" "bootstrap" {
  script_uuid    = zstack_instance_scripts.bootstrap.uuid
  instance_uuid  = zstack_instance.vm.uuid
  script_timeout = var.script_timeout
}

output "vm_uuid" {
  description = "Created VM UUID."
  value       = zstack_instance.vm.uuid
}

output "ssh_key_uuid" {
  description = "Imported SSH key UUID."
  value       = zstack_ssh_key_pair.admin.uuid
}

output "script_execution_status" {
  description = "Script execution status."
  value       = zstack_instance_scripts_execution.bootstrap.status
}
