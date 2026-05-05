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

variable "vm_count" {
  type    = number
  default = 10
}

variable "vm_name_prefix" {
  type    = string
  default = "tf-batch"
}

variable "image_name" {
  type = string
}

variable "l3_network_name" {
  type = string
}

variable "instance_offering_name" {
  type = string
}

variable "static_ips" {
  type        = list(string)
  description = "Optional static IP list. Leave empty to let ZStack allocate addresses."
  default     = []
}
