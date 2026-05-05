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

variable "vm_name" {
  description = "Name of the vm to create or query."
  type        = string
  default     = "tf-init-demo"
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
  description = "IP address for the static."
  type        = string
  default     = null
}

variable "ssh_key_name" {
  description = "Name of the ssh key to create or query."
  type        = string
  default     = "tf-admin-key"
}

variable "ssh_public_key" {
  type        = string
  description = "Public key content to import into ZStack."
}

variable "script_name" {
  description = "Name of the script to create or query."
  type        = string
  default     = "tf-bootstrap"
}

variable "script_content" {
  type        = string
  description = "Plain text shell script content."
  default     = "echo hello from terraform"
}

variable "script_timeout" {
  description = "Time value for the script timeout."
  type        = number
  default     = 180
}
