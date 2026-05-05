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

variable "account_name" {
  type    = string
  default = "tf-automation"
}

variable "account_password" {
  type      = string
  sensitive = true
}

variable "project_name" {
  type    = string
  default = "tf-project"
}

variable "virtual_id_name" {
  type    = string
  default = "tf-virtual-id"
}

variable "virtual_id_password" {
  type      = string
  sensitive = true
}
