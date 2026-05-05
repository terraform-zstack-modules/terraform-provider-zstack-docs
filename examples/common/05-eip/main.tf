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

resource "zstack_vip" "public" {
  name            = var.vip_name
  description     = "VIP created by Terraform"
  l3_network_uuid = var.public_l3_network_uuid
}

resource "zstack_eip" "public" {
  name        = var.eip_name
  description = "EIP created by Terraform"
  vip_uuid    = zstack_vip.public.uuid
  vm_nic_uuid = var.vm_nic_uuid
}

output "vip_uuid" {
  description = "Created VIP UUID."
  value       = zstack_vip.public.uuid
}

output "eip_uuid" {
  description = "Created EIP UUID."
  value       = zstack_eip.public.uuid
}
