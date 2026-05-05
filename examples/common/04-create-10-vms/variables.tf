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

variable "vm_count" {
  description = "Number of vm items to create or use."
  type        = number
  default     = 10
}

variable "vm_name_prefix" {
  description = "Name prefix used when creating vm resources."
  type        = string
  default     = "tf-batch"
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

variable "static_ips" {
  type        = list(string)
  description = "Optional static IP list. Leave empty to let ZStack allocate addresses."
  default     = []
}
