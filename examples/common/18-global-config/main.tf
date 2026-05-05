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

data "zstack_global_configs" "selected" {
  category = var.global_config_category
  name     = var.global_config_name
}

resource "zstack_global_config" "managed" {
  count = var.manage_global_config ? 1 : 0

  category = var.global_config_category
  name     = var.global_config_name
  value    = var.global_config_value
}

output "current_global_config" {
  description = "Current global config value and metadata."
  value       = data.zstack_global_configs.selected.global_configs[0]
}

output "managed_global_config" {
  description = "Managed global config state when enabled."
  value       = try(zstack_global_config.managed[0], null)
}
