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

resource "zstack_cdp_policy" "daily" {
  name                        = var.cdp_policy_name
  description                 = "CDP policy managed by Terraform"
  recovery_point_per_second   = var.recovery_point_per_second
  retention_time_per_day      = var.retention_time_per_day
  full_backup_interval_in_day = var.full_backup_interval_in_day
  expire_time_in_day          = var.expire_time_in_day
  daily_rp_since_day          = var.daily_rp_since_day
  hourly_rp_since_day         = var.hourly_rp_since_day
}

resource "zstack_cdp_task" "resources" {
  name                = var.cdp_task_name
  description         = "CDP task managed by Terraform"
  policy_uuid         = zstack_cdp_policy.daily.uuid
  backup_storage_uuid = var.backup_storage_uuid
  resource_uuids      = var.cdp_resource_uuids
  task_type           = var.cdp_task_type
  backup_bandwidth    = var.backup_bandwidth
  max_capacity        = var.max_capacity
  max_latency         = var.max_latency
}

resource "zstack_volume_backup" "data" {
  name                = var.volume_backup_name
  description         = "Volume backup managed by Terraform"
  volume_uuid         = var.volume_uuid
  backup_storage_uuid = var.backup_storage_uuid
}

resource "zstack_database_backup" "platform" {
  name                = var.database_backup_name
  description         = "Database backup managed by Terraform"
  backup_storage_uuid = var.backup_storage_uuid
}

resource "zstack_zbox_backup" "optional" {
  count = var.zbox_uuid == null ? 0 : 1

  name        = var.zbox_backup_name
  description = "ZBox backup managed by Terraform"
  zbox_uuid   = var.zbox_uuid
  dry_run     = var.zbox_dry_run
}

output "cdp_policy_uuid" {
  description = "CDP policy UUID."
  value       = zstack_cdp_policy.daily.uuid
}

output "cdp_task_uuid" {
  description = "CDP task UUID."
  value       = zstack_cdp_task.resources.uuid
}

output "volume_backup_uuid" {
  description = "Volume backup UUID."
  value       = zstack_volume_backup.data.uuid
}

output "database_backup_uuid" {
  description = "Database backup UUID."
  value       = zstack_database_backup.platform.uuid
}

output "zbox_backup_uuid" {
  description = "ZBox backup UUID when zbox_uuid is set."
  value       = try(zstack_zbox_backup.optional[0].uuid, null)
}
