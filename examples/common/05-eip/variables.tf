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

variable "public_l3_network_uuid" {
  type        = string
  description = "Public L3 network UUID used to allocate the VIP."
}

variable "vm_nic_uuid" {
  type        = string
  description = "VM NIC UUID that should receive the EIP."
}
