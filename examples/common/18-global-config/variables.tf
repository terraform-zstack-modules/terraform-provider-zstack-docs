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

variable "global_config_category" {
  type        = string
  description = "Global config category."
}

variable "global_config_name" {
  type        = string
  description = "Global config name."
}

variable "global_config_value" {
  type        = string
  description = "Target global config value."
  default     = null
}

variable "manage_global_config" {
  type        = bool
  description = "Whether Terraform should manage and update the global config."
  default     = false
}
