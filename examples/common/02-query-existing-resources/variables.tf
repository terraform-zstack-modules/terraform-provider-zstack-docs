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

variable "image_name" {
  type        = string
  description = "Existing image name."
}

variable "l3_network_name" {
  type        = string
  description = "Existing L3 network name."
}

variable "instance_offering_name" {
  type        = string
  description = "Existing instance offering name."
}

variable "disk_offering_name" {
  type        = string
  description = "Existing disk offering name."
}

variable "zone_name" {
  type        = string
  description = "Existing zone name."
}

variable "cluster_name" {
  type        = string
  description = "Existing cluster name."
}

variable "host_name" {
  type        = string
  description = "Existing host name."
}
