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

variable "security_group_name" {
  type    = string
  default = "tf-web"
}

variable "vm_name" {
  type    = string
  default = "tf-sg-demo"
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

variable "static_ip" {
  type        = string
  description = "Optional static IP for the VM NIC."
  default     = null
}

variable "vswitch_type" {
  type        = string
  description = "Security group vSwitch type, for example LinuxBridge or OvnDpdk."
  default     = "LinuxBridge"
}

variable "ingress_rules" {
  type = map(object({
    protocol                = string
    priority                = number
    ip_ranges               = string
    destination_port_ranges = string
    description             = string
  }))
}
