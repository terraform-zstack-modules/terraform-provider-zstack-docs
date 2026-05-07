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

variable "image_name_pattern" {
  type        = string
  description = "Image name pattern used for environment discovery."
  default     = "%"
}

variable "l3_network_name_pattern" {
  type        = string
  description = "L3 network name pattern used for environment discovery."
  default     = "%"
}

variable "instance_offering_name_pattern" {
  type        = string
  description = "Instance offering name pattern used for environment discovery."
  default     = "%"
}

variable "disk_offering_name_pattern" {
  type        = string
  description = "Disk offering name pattern used for environment discovery."
  default     = "%"
}

variable "zone_name_pattern" {
  type        = string
  description = "Zone name pattern used for environment discovery."
  default     = "%"
}

variable "cluster_name_pattern" {
  type        = string
  description = "Cluster name pattern used for environment discovery."
  default     = "%"
}

variable "host_name_pattern" {
  type        = string
  description = "Host name pattern used for environment discovery."
  default     = "%"
}
