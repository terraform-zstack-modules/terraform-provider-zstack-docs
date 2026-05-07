variable "zstack_host" {
  type        = string
  description = "ZStack management endpoint host or IP address."
}

variable "zstack_port" {
  type        = number
  description = "ZStack management endpoint port."
  default     = 8080
}

variable "zstack_access_key_id" {
  type        = string
  description = "AccessKey ID used to authenticate to ZStack."
}

variable "zstack_access_key_secret" {
  type        = string
  description = "AccessKey secret used to authenticate to ZStack."
  sensitive   = true
}

variable "account_name" {
  type        = string
  description = "Automation account name."
  default     = "tf-automation"
}

variable "account_password" {
  type        = string
  description = "Initial password for the automation account."
  sensitive   = true
}

variable "account_description" {
  type        = string
  description = "Automation account description."
  default     = "Terraform automation account"
}

variable "project_name" {
  type        = string
  description = "IAM2 project name for automation workflows."
  default     = "tf-automation-project"
}

variable "project_description" {
  type        = string
  description = "IAM2 project description."
  default     = "Terraform automation project"
}

variable "virtual_id_name" {
  type        = string
  description = "IAM2 virtual ID name for automation workflows."
  default     = "tf-automation-virtual-id"
}

variable "virtual_id_password" {
  type        = string
  description = "Initial password for the IAM2 virtual ID."
  sensitive   = true
}

variable "virtual_id_description" {
  type        = string
  description = "IAM2 virtual ID description."
  default     = "Terraform automation virtual ID"
}

variable "access_key_description" {
  type        = string
  description = "Description for the generated automation AccessKey."
  default     = "AccessKey for Terraform automation"
}
