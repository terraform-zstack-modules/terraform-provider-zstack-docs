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

variable "name_prefix" {
  type        = string
  description = "Prefix used for all resources in this reference deployment."
  default     = "prod-web"
}

variable "environment" {
  type        = string
  description = "Environment tag value."
  default     = "production"
}

variable "application" {
  type        = string
  description = "Application tag value."
  default     = "three-tier-web"
}

variable "owner" {
  type        = string
  description = "Owner tag value."
}

variable "image_name" {
  type        = string
  description = "Image name used by web and application VMs."
}

variable "private_l3_network_name" {
  type        = string
  description = "Private L3 network name used by web and application VMs."
}

variable "public_l3_network_name_pattern" {
  type        = string
  description = "Public L3 network name pattern used to allocate the web VIP."
}

variable "web_instance_offering_name" {
  type        = string
  description = "Instance offering name for web VMs."
}

variable "app_instance_offering_name" {
  type        = string
  description = "Instance offering name for application VMs."
}

variable "app_disk_offering_name" {
  type        = string
  description = "Disk offering name for application data volumes."
}

variable "web_instance_count" {
  type        = number
  description = "Number of web tier VMs."
  default     = 2
}

variable "app_instance_count" {
  type        = number
  description = "Number of application tier VMs."
  default     = 2
}

variable "web_port" {
  type        = number
  description = "HTTP frontend and web backend port."
  default     = 80
}

variable "app_port" {
  type        = number
  description = "Application tier service port."
  default     = 8080
}

variable "web_ingress_cidr" {
  type        = string
  description = "CIDR allowed to reach the web tier."
  default     = "10.0.0.0/8"
}

variable "app_ingress_cidr" {
  type        = string
  description = "CIDR allowed to reach the application tier."
  default     = "10.0.0.0/8"
}

variable "vswitch_type" {
  type        = string
  description = "Security group vSwitch type, for example LinuxBridge or OvnDpdk."
  default     = "LinuxBridge"
}
