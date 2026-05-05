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

variable "topic_name" {
  description = "Name of the topic to create or query."
  type        = string
  default     = "tf-ops-topic"
}

variable "email_endpoint_name" {
  description = "Name of the email endpoint to create or query."
  type        = string
  default     = "tf-ops-email"
}

variable "notification_email" {
  description = "Email address for the notification."
  type        = string
}

variable "webhook_name" {
  description = "Name of the webhook to create or query."
  type        = string
  default     = "tf-ops-webhook"
}

variable "webhook_type" {
  description = "Type value for the webhook."
  type        = string
  default     = "HTTP"
}

variable "webhook_url" {
  description = "Notification webhook endpoint URL."
  type        = string
}

variable "webhook_opaque" {
  description = "Input value for webhook opaque."
  type        = string
  default     = "{}"
}

variable "alarm_name" {
  description = "Name of the alarm to create or query."
  type        = string
  default     = "tf-high-cpu"
}

variable "metric_namespace" {
  description = "Input value for metric namespace."
  type        = string
  default     = "ZStack/VM"
}

variable "metric_name" {
  description = "Name of the metric to create or query."
  type        = string
  default     = "CPUUtilization"
}

variable "comparison_operator" {
  description = "Input value for comparison operator."
  type        = string
  default     = "GreaterThanOrEqualTo"
}

variable "threshold" {
  description = "Input value for threshold."
  type        = number
  default     = 80
}

variable "period" {
  description = "Input value for period."
  type        = number
  default     = 60
}

variable "repeat_interval" {
  description = "Interval value for the repeat interval."
  type        = number
  default     = 300
}
