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

variable "vm_name" {
  type    = string
  default = "tf-volume-demo"
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

variable "disk_offering_name" {
  type = string
}

variable "data_volume_name" {
  type    = string
  default = "tf-data-volume"
}
