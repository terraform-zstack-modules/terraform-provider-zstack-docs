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

variable "vm_name" {
  description = "Name of the vm to create or query."
  type        = string
  default     = "tf-volume-demo"
}

variable "image_name" {
  description = "Name of the image to create or query."
  type        = string
}

variable "l3_network_name" {
  description = "Name of the l3 network to create or query."
  type        = string
}

variable "instance_offering_name" {
  description = "Name of the instance offering to create or query."
  type        = string
}

variable "disk_offering_name" {
  description = "Name of the disk offering to create or query."
  type        = string
}

variable "data_volume_name" {
  description = "Name of the data volume to create or query."
  type        = string
  default     = "tf-data-volume"
}
