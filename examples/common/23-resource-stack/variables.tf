variable "zstack_host" { type = string }
variable "zstack_port" {
  type    = number
  default = 8080
}
variable "zstack_access_key_id" { type = string }
variable "zstack_access_key_secret" {
  type      = string
  sensitive = true
}

variable "stack_template_name" { default = "tf-stack-template" }
variable "stack_template_type" { default = null }
variable "resource_stack_name" { default = "tf-resource-stack" }
variable "resource_stack_type" { default = null }
variable "stack_parameters" { default = null }
variable "rollback" { default = true }

variable "preconfiguration_template_name" { default = "tf-preconfiguration-template" }
variable "preconfiguration_template_type" { default = "kickstart" }
variable "preconfiguration_distribution" { default = "Linux" }
variable "preconfiguration_content" {
  type        = string
  description = "Preconfiguration template content. Must contain required ZStack markers."
}
