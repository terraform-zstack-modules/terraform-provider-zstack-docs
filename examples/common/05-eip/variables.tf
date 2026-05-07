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

variable "vip_name" {
  description = "Name of the vip to create or query."
  type        = string
  default     = "tf-demo-vip"
}

variable "eip_name" {
  description = "Name of the eip to create or query."
  type        = string
  default     = "tf-demo-eip"
}

variable "public_l3_network_name_pattern" {
  type        = string
  description = "Public L3 network name pattern used to allocate the VIP."
  default     = "%"
}

variable "target_vm_name" {
  type        = string
  description = "Existing VM name whose NIC should receive the EIP."
  default     = "tf-demo-01"
}

variable "target_vm_nic_index" {
  type        = number
  description = "Index of the target VM NIC to bind the EIP to."
  default     = 0
}
