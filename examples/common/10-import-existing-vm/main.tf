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

import {
  to = zstack_instance.existing
  id = var.existing_vm_uuid
}

resource "zstack_instance" "existing" {
  name       = var.existing_vm_name
  image_uuid = var.existing_image_uuid

  # Fill in the remaining arguments to match the imported VM. Do not apply this
  # configuration until terraform plan is no-op or only shows accepted changes.
  cpu_num     = var.cpu_num
  memory_size = var.memory_size

  network_interfaces = [
    {
      l3_network_uuid = var.l3_network_uuid
      default_l3      = true
      static_ip       = var.static_ip
    }
  ]
}

output "imported_vm" {
  description = "Imported VM state after Terraform refresh."
  value       = zstack_instance.existing
}
