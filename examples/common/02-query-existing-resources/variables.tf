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
