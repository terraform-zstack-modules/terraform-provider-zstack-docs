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

variable "security_group_name" {
  description = "Name of the security group to create or query."
  type        = string
  default     = "tf-web"
}

variable "vm_name" {
  description = "Name of the vm to create or query."
  type        = string
  default     = "tf-sg-demo"
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

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) : trimspace(rule.ip_ranges) != "0.0.0.0/0"
    ])
    error_message = "Ingress rule ip_ranges must not be 0.0.0.0/0 in this example. Use a specific trusted CIDR."
  }
}
