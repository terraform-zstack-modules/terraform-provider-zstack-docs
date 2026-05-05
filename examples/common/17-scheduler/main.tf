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

resource "zstack_scheduler_job" "target" {
  name                 = var.job_name
  description          = "Scheduler job managed by Terraform"
  type                 = var.job_type
  target_resource_uuid = var.target_resource_uuid
}

resource "zstack_scheduler_trigger" "schedule" {
  name               = var.trigger_name
  description        = "Scheduler trigger managed by Terraform"
  scheduler_type     = var.scheduler_type
  cron               = var.cron
  scheduler_interval = var.scheduler_interval
  repeat_count       = var.repeat_count
  start_time         = var.start_time
}

output "scheduler_job_uuid" {
  description = "Scheduler job UUID."
  value       = zstack_scheduler_job.target.uuid
}

output "scheduler_trigger_uuid" {
  description = "Scheduler trigger UUID."
  value       = zstack_scheduler_trigger.schedule.uuid
}
