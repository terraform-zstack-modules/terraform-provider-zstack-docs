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

variable "vip_name" {
  type    = string
  default = "tf-demo-vip"
}

variable "eip_name" {
  type    = string
  default = "tf-demo-eip"
}

variable "public_l3_network_uuid" {
  type        = string
  description = "Public L3 network UUID used to allocate the VIP."
}

variable "vm_nic_uuid" {
  type        = string
  description = "VM NIC UUID that should receive the EIP."
}
