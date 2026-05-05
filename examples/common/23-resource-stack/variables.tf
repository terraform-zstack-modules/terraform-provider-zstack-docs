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

variable "stack_template_name" {
  description = "Name of the stack template to create or query."
  default     = "tf-stack-template"
}

variable "stack_template_type" {
  description = "Type value for the stack template."
  default     = null
}

variable "resource_stack_name" {
  description = "Name of the resource stack to create or query."
  default     = "tf-resource-stack"
}

variable "resource_stack_type" {
  description = "Type value for the resource stack."
  default     = null
}

variable "stack_parameters" {
  description = "Input value for stack parameters."
  default     = null
}

variable "rollback" {
  description = "Whether to rollback."
  default     = true
}

variable "preconfiguration_template_name" {
  description = "Name of the preconfiguration template to create or query."
  default     = "tf-preconfiguration-template"
}

variable "preconfiguration_template_type" {
  description = "Type value for the preconfiguration template."
  default     = "kickstart"
}

variable "preconfiguration_distribution" {
  description = "Input value for preconfiguration distribution."
  default     = "Linux"
}

variable "preconfiguration_content" {
  type        = string
  description = "Preconfiguration template content. Must contain required ZStack markers."
}
