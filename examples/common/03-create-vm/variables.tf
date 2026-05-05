variable "zstack_host" {
  type        = string
  description = "ZStack management node host or IP address."
}

variable "zstack_port" {
  type        = number
  description = "ZStack management node API port."
  default     = 8080
}

variable "zstack_access_key_id" {
  type        = string
  description = "ZStack AccessKey ID used by Terraform."
}

variable "zstack_access_key_secret" {
  type        = string
  description = "ZStack AccessKey Secret used by Terraform."
  sensitive   = true
}

variable "vm_name" {
  type        = string
  description = "Name of the VM to create."
}

variable "image_name" {
  type        = string
  description = "Name of the image used to create the VM."
}

variable "l3_network_name" {
  type        = string
  description = "Name of the L3 network attached to the VM."
}

variable "instance_offering_name" {
  type        = string
  description = "Name of the instance offering used by the VM."
}

variable "static_ip" {
  type        = string
  description = "Optional static IP for the VM NIC. Set to null to let ZStack allocate one."
  default     = null
}

variable "never_stop" {
  type        = bool
  description = "Whether the VM should use never-stop HA behavior."
  default     = false
}
