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

variable "tag_name" {
  description = "Name of the tag to create or query."
  type        = string
  default     = "environment"
}

variable "tag_description" {
  description = "Input value for tag description."
  type        = string
  default     = "Environment tag managed by Terraform"
}

variable "tag_value" {
  description = "Value assigned to the tag."
  type        = string
  default     = "production"
}

variable "tag_color" {
  description = "Color value for the tag."
  type        = string
  default     = "#57D355"
}

variable "resource_uuids" {
  type        = list(string)
  description = "Resource UUIDs to attach the tag to."
}
