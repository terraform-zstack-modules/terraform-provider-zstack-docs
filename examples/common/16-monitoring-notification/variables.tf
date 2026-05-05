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

variable "topic_name" {
  type    = string
  default = "tf-ops-topic"
}

variable "email_endpoint_name" {
  type    = string
  default = "tf-ops-email"
}

variable "notification_email" {
  type = string
}

variable "webhook_name" {
  type    = string
  default = "tf-ops-webhook"
}

variable "webhook_type" {
  type    = string
  default = "HTTP"
}

variable "webhook_url" {
  type = string
}

variable "webhook_opaque" {
  type    = string
  default = "{}"
}

variable "alarm_name" {
  type    = string
  default = "tf-high-cpu"
}

variable "metric_namespace" {
  type    = string
  default = "ZStack/VM"
}

variable "metric_name" {
  type    = string
  default = "CPUUtilization"
}

variable "comparison_operator" {
  type    = string
  default = "GreaterThanOrEqualTo"
}

variable "threshold" {
  type    = number
  default = 80
}

variable "period" {
  type    = number
  default = 60
}

variable "repeat_interval" {
  type    = number
  default = 300
}
