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

data "zstack_license_authorized_capacity" "current" {}

data "zstack_license_authorized_nodes" "nodes" {}

resource "zstack_license" "uploaded" {
  count = var.upload_license ? 1 : 0

  management_node_uuid = var.management_node_uuid
  license              = var.license_text
}

output "license_authorized_capacity" {
  description = "Current authorized capacity."
  value       = data.zstack_license_authorized_capacity.current
}

output "license_authorized_nodes" {
  description = "Authorized nodes matching the requested pattern."
  value       = data.zstack_license_authorized_nodes.nodes.nodes
}

output "uploaded_license" {
  description = "Uploaded license metadata when upload_license is true."
  value       = try(zstack_license.uploaded[0], null)
  sensitive   = true
}
