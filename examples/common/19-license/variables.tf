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

variable "node_name_pattern" {
  type        = string
  description = "Authorized node name pattern."
  default     = "%"
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
