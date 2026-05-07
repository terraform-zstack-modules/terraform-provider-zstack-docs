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

data "zstack_l3networks" "public" {
  name_pattern = var.public_l3_network_name_pattern
}

data "zstack_instances" "target" {
  name = var.target_vm_name
}

resource "zstack_vip" "public" {
  name            = var.vip_name
  description     = "VIP created by Terraform"
  l3_network_uuid = data.zstack_l3networks.public.l3networks[0].uuid
}

resource "zstack_eip" "public" {
  name        = var.eip_name
  description = "EIP created by Terraform"
  vip_uuid    = zstack_vip.public.uuid
  vm_nic_uuid = data.zstack_instances.target.vminstances[0].vm_nics[var.target_vm_nic_index].uuid
}

output "selected_public_l3_network" {
  description = "Public L3 network selected by the data source."
  value       = data.zstack_l3networks.public.l3networks[0]
}

output "selected_vm_nic_uuid" {
  description = "VM NIC UUID selected for EIP binding."
  value       = data.zstack_instances.target.vminstances[0].vm_nics[var.target_vm_nic_index].uuid
}

output "vip_uuid" {
  description = "Created VIP UUID."
  value       = zstack_vip.public.uuid
}

output "eip_uuid" {
  description = "Created EIP UUID."
  value       = zstack_eip.public.uuid
}
