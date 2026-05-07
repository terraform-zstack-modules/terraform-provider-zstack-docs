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

variable "cluster_name" {
  type        = string
  description = "Kubernetes cluster name used as the resource name prefix."
  default     = "prod-k8s"
}

variable "node_image_name" {
  type        = string
  description = "Node image name. Use a hardened image prepared for Kubernetes installation."
}

variable "private_l3_network_name" {
  type        = string
  description = "Private L3 network name used by Kubernetes nodes."
}

variable "public_l3_network_name_pattern" {
  type        = string
  description = "Public L3 network name pattern used for the Kubernetes API VIP."
}

variable "control_plane_offering_name" {
  type        = string
  description = "Instance offering name for control-plane nodes."
}

variable "worker_offering_name" {
  type        = string
  description = "Instance offering name for worker nodes."
}

variable "control_plane_count" {
  type        = number
  description = "Number of control-plane nodes."
  default     = 3
}

variable "worker_count" {
  type        = number
  description = "Number of worker nodes."
  default     = 3
}

variable "api_allowed_cidr" {
  type        = string
  description = "CIDR allowed to reach the Kubernetes API endpoint."
  default     = "10.0.0.0/8"
}

variable "node_internal_cidr" {
  type        = string
  description = "CIDR used for node-to-node Kubernetes traffic."
  default     = "10.0.0.0/8"
}

variable "vswitch_type" {
  type        = string
  description = "Security group vSwitch type, for example LinuxBridge or OvnDpdk."
  default     = "LinuxBridge"
}
