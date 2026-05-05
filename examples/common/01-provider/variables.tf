variable "zstack_host" {
  type        = string
  description = "ZStack management node host or address."
}

variable "zstack_port" {
  type        = number
  description = "ZStack management node API port."
  default     = 8080
}

variable "zstack_access_key_id" {
  type        = string
  description = "ZStack access key ID."
}

variable "zstack_access_key_secret" {
  type        = string
  sensitive   = true
  description = "ZStack access key secret."
}
