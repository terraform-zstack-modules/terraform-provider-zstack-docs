variable "zstack_host" {
  description = "ZStack management endpoint host or IP address."
  type        = string
}

variable "zstack_port" {
  description = "ZStack management endpoint port."
  type        = number
  default     = 8080
}

variable "zstack_access_key_id" {
  description = "AccessKey ID used to authenticate to ZStack."
  type        = string
}

variable "zstack_access_key_secret" {
  description = "AccessKey secret used to authenticate to ZStack."
  type        = string
  sensitive   = true
}

variable "backup_storage_uuid" {
  type        = string
  description = "Backup storage UUID."
}

variable "cdp_policy_name" {
  description = "Name of the cdp policy to create or query."
  type        = string
  default     = "tf-cdp-policy"
}

variable "recovery_point_per_second" {
  description = "Input value for recovery point per second."
  type        = number
  default     = 1
}

variable "retention_time_per_day" {
  description = "Time value for the retention time per day."
  type        = number
  default     = 7
}

variable "full_backup_interval_in_day" {
  description = "Interval value for the full backup interval in day."
  type        = number
  default     = 7
}

variable "expire_time_in_day" {
  description = "Time value for the expire time in day."
  type        = number
  default     = 30
}

variable "daily_rp_since_day" {
  description = "Input value for daily rp since day."
  type        = number
  default     = 7
}

variable "hourly_rp_since_day" {
  description = "Input value for hourly rp since day."
  type        = number
  default     = 1
}

variable "cdp_task_name" {
  description = "Name of the cdp task to create or query."
  type        = string
  default     = "tf-cdp-task"
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
  description = "Input value for backup bandwidth."
  type        = number
  default     = null
}

variable "max_capacity" {
  description = "Input value for max capacity."
  type        = number
  default     = null
}

variable "max_latency" {
  description = "Input value for max latency."
  type        = number
  default     = null
}

variable "volume_backup_name" {
  description = "Name of the volume backup to create or query."
  type        = string
  default     = "tf-volume-backup"
}

variable "volume_uuid" {
  type        = string
  description = "Volume UUID to back up."
}

variable "database_backup_name" {
  description = "Name of the database backup to create or query."
  type        = string
  default     = "tf-database-backup"
}

variable "zbox_uuid" {
  type        = string
  description = "Optional ZBox UUID to back up."
  default     = null
}

variable "zbox_backup_name" {
  description = "Name of the zbox backup to create or query."
  type        = string
  default     = "tf-zbox-backup"
}

variable "zbox_dry_run" {
  description = "Whether to zbox dry run."
  type        = bool
  default     = true
}
