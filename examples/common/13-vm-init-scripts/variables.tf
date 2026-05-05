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

variable "vm_name" {
  type    = string
  default = "tf-init-demo"
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
  type    = string
  default = null
}

variable "ssh_key_name" {
  type    = string
  default = "tf-admin-key"
}

variable "ssh_public_key" {
  type        = string
  description = "Public key content to import into ZStack."
}

variable "script_name" {
  type    = string
  default = "tf-bootstrap"
}

variable "script_content" {
  type        = string
  description = "Plain text shell script content."
  default     = "echo hello from terraform"
}

variable "script_timeout" {
  type    = number
  default = 180
}
