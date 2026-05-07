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

variable "public_l3_network_name_pattern" {
  type        = string
  description = "Public L3 network name pattern used to allocate the VIP."
  default     = "%"
}

variable "vip_name" {
  description = "Name of the vip to create or query."
  type        = string
  default     = "tf-web-vip"
}

variable "load_balancer_name" {
  description = "Name of the load balancer to create or query."
  type        = string
  default     = "tf-web-lb"
}

variable "server_group_name" {
  description = "Name of the server group to create or query."
  type        = string
  default     = "tf-web-backends"
}

variable "listener_name" {
  description = "Name of the listener to create or query."
  type        = string
  default     = "tf-web-http"
}

variable "frontend_port" {
  description = "Port number for the frontend."
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "Port number for the backend."
  type        = number
  default     = 8080
}
