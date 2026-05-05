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

variable "existing_vm_uuid" {
  type        = string
  description = "UUID of the existing VM to import."
}

variable "existing_vm_name" {
  type        = string
  description = "Name of the existing VM."
}

variable "existing_image_uuid" {
  type        = string
  description = "Image UUID used by the existing VM."
}

variable "cpu_num" {
  type        = number
  description = "CPU count matching the existing VM."
}

variable "memory_size" {
  type        = number
  description = "Memory size in MB matching the existing VM."
}

variable "l3_network_uuid" {
  type        = string
  description = "L3 network UUID for the imported VM NIC."
}

variable "static_ip" {
  type        = string
  description = "Static IP for the imported VM NIC. Set null if not managed."
  default     = null
}
