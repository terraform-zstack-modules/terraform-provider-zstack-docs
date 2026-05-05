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

variable "account_name" {
  description = "Name of the account to create or query."
  type        = string
  default     = "tf-automation"
}

variable "account_password" {
  description = "Initial password for the managed ZStack account."
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Name of the project to create or query."
  type        = string
  default     = "tf-project"
}

variable "virtual_id_name" {
  description = "Name of the virtual id to create or query."
  type        = string
  default     = "tf-virtual-id"
}

variable "virtual_id_password" {
  description = "Initial password for the managed IAM2 virtual ID."
  type        = string
  sensitive   = true
}
