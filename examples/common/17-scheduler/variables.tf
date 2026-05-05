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

variable "job_name" {
  description = "Name of the job to create or query."
  type        = string
  default     = "tf-scheduler-job"
}

variable "job_type" {
  type        = string
  description = "Scheduler job type supported by the target ZStack environment."
}

variable "target_resource_uuid" {
  type        = string
  description = "Target resource UUID for the scheduler job."
}

variable "trigger_name" {
  description = "Name of the trigger to create or query."
  type        = string
  default     = "tf-scheduler-trigger"
}

variable "scheduler_type" {
  type        = string
  description = "Scheduler trigger type, for example simple or cron."
  default     = "cron"
}

variable "cron" {
  type        = string
  description = "Cron expression for cron trigger."
  default     = "0 0 2 * * ?"
}

variable "scheduler_interval" {
  type        = number
  description = "Scheduler interval in seconds for simple trigger."
  default     = null
}

variable "repeat_count" {
  type        = number
  description = "Repeat count for simple trigger."
  default     = null
}

variable "start_time" {
  type        = number
  description = "Unix timestamp start time."
  default     = null
}
