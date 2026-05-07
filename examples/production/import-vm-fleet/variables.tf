variable "zstack_host" {
  type        = string
  description = "ZStack management endpoint host or IP address."
}

variable "zstack_port" {
  type        = number
  description = "ZStack management endpoint port."
  default     = 8080
}

variable "zstack_access_key_id" {
  type        = string
  description = "AccessKey ID used to authenticate to ZStack."
}

variable "zstack_access_key_secret" {
  type        = string
  description = "AccessKey secret used to authenticate to ZStack."
  sensitive   = true
}

variable "vm_01" {
  type = object({
    uuid            = string
    name            = string
    description     = string
    image_uuid      = string
    cpu_num         = number
    memory_size     = number
    l3_network_uuid = string
    static_ip       = string
  })
  description = "First existing VM to import. Values must match the remote VM."
}

variable "vm_02" {
  type = object({
    uuid            = string
    name            = string
    description     = string
    image_uuid      = string
    cpu_num         = number
    memory_size     = number
    l3_network_uuid = string
    static_ip       = string
  })
  description = "Second existing VM to import. Values must match the remote VM."
}
