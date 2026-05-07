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

variable "upload_license" {
  type        = bool
  description = "Whether to upload a license."
  default     = false
}

variable "management_node_uuid" {
  type        = string
  description = "Management node UUID used for license upload."
  default     = null
}

variable "license_text" {
  type        = string
  description = "License text to upload."
  sensitive   = true
  default     = null
}
