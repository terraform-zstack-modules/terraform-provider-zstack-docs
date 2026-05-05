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

variable "tag_name" {
  type    = string
  default = "environment"
}

variable "tag_description" {
  type    = string
  default = "Environment tag managed by Terraform"
}

variable "tag_value" {
  type    = string
  default = "production"
}

variable "tag_color" {
  type    = string
  default = "#57D355"
}

variable "resource_uuids" {
  type        = list(string)
  description = "Resource UUIDs to attach the tag to."
}
