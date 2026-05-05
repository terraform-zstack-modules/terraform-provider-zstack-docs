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

resource "zstack_sns_topic" "ops" {
  name        = var.topic_name
  description = "Operations notification topic managed by Terraform"
}

resource "zstack_sns_email_endpoint" "ops" {
  name        = var.email_endpoint_name
  description = "Operations email endpoint managed by Terraform"
  email       = var.notification_email
}

resource "zstack_webhook" "ops" {
  name        = var.webhook_name
  description = "Operations webhook managed by Terraform"
  type        = var.webhook_type
  url         = var.webhook_url
  opaque      = var.webhook_opaque
}

resource "zstack_alarm" "cpu" {
  name                = var.alarm_name
  description         = "CPU alarm managed by Terraform"
  namespace           = var.metric_namespace
  metric_name         = var.metric_name
  comparison_operator = var.comparison_operator
  threshold           = var.threshold
  period              = var.period
  repeat_interval     = var.repeat_interval
}

output "topic_uuid" {
  description = "SNS topic UUID."
  value       = zstack_sns_topic.ops.uuid
}

output "email_endpoint_uuid" {
  description = "SNS email endpoint UUID."
  value       = zstack_sns_email_endpoint.ops.uuid
}

output "webhook_uuid" {
  description = "Webhook UUID."
  value       = zstack_webhook.ops.uuid
}

output "alarm_uuid" {
  description = "Alarm UUID."
  value       = zstack_alarm.cpu.uuid
}
