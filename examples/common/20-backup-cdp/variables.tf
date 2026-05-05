variable "zstack_host" {
  type = string
}

variable "zstack_port" {
  type    = number
  default = 8080
}

variable "zstack_access_key_id" {
  type = string
}

variable "zstack_access_key_secret" {
  type      = string
  sensitive = true
}

variable "backup_storage_uuid" {
  type        = string
  description = "Backup storage UUID."
}

variable "cdp_policy_name" {
  type    = string
  default = "tf-cdp-policy"
}

variable "recovery_point_per_second" {
  type    = number
  default = 1
}

variable "retention_time_per_day" {
  type    = number
  default = 7
}

variable "full_backup_interval_in_day" {
  type    = number
  default = 7
}

variable "expire_time_in_day" {
  type    = number
  default = 30
}

variable "daily_rp_since_day" {
  type    = number
  default = 7
}

variable "hourly_rp_since_day" {
  type    = number
  default = 1
}

variable "cdp_task_name" {
  type    = string
  default = "tf-cdp-task"
}

variable "cdp_resource_uuids" {
  type        = list(string)
  description = "Resource UUIDs protected by the CDP task."
}

variable "cdp_task_type" {
  type        = string
  description = "CDP task type supported by ZStack."
}

variable "backup_bandwidth" {
  type    = number
  default = null
}

variable "max_capacity" {
  type    = number
  default = null
}

variable "max_latency" {
  type    = number
  default = null
}

variable "volume_backup_name" {
  type    = string
  default = "tf-volume-backup"
}

variable "volume_uuid" {
  type        = string
  description = "Volume UUID to back up."
}

variable "database_backup_name" {
  type    = string
  default = "tf-database-backup"
}

variable "zbox_uuid" {
  type        = string
  description = "Optional ZBox UUID to back up."
  default     = null
}

variable "zbox_backup_name" {
  type    = string
  default = "tf-zbox-backup"
}

variable "zbox_dry_run" {
  type    = bool
  default = true
}
