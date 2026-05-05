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

variable "ipsec_name" {
  description = "Name of the ipsec to create or query."
  default     = "tf-ipsec"
}

variable "vip_uuid" {
  description = "UUID of the vip to use in this example."
  type        = string
}

variable "peer_address" {
  description = "Input value for peer address."
  type        = string
}

variable "auth_key" {
  description = "Pre-shared key or authentication secret for the IPsec connection."
  type        = string
  sensitive   = true
}

variable "auth_mode" {
  description = "Mode value for the auth."
  default     = "psk"
}

variable "ike_auth_algorithm" {
  description = "Algorithm value for the ike auth."
  default     = null
}

variable "ike_encryption_algorithm" {
  description = "Algorithm value for the ike encryption."
  default     = null
}

variable "policy_auth_algorithm" {
  description = "Algorithm value for the policy auth."
  default     = null
}

variable "policy_encryption_algorithm" {
  description = "Algorithm value for the policy encryption."
  default     = null
}

variable "policy_mode" {
  description = "Mode value for the policy."
  default     = null
}

variable "transform_protocol" {
  description = "Protocol value for the transform."
  default     = null
}

variable "pfs" {
  description = "Input value for pfs."
  default     = null
}

variable "rule_set_name" {
  description = "Name of the rule set to create or query."
  default     = "tf-policy-route-set"
}

variable "vrouter_uuid" {
  description = "UUID of the vrouter to use in this example."
  type        = string
}

variable "rule_set_type" {
  description = "Type value for the rule set."
  default     = null
}

variable "route_table_uuid" {
  description = "UUID of the route table to use in this example."
  type        = string
}

variable "rule_number" {
  description = "Input value for rule number."
  default     = 100
}

variable "source_ip" {
  description = "IP address for the source."
  default     = null
}

variable "source_port" {
  description = "Port number for the source."
  default     = null
}

variable "dest_ip" {
  description = "IP address for the dest."
  default     = null
}

variable "dest_port" {
  description = "Port number for the dest."
  default     = null
}

variable "protocol" {
  description = "Input value for protocol."
  default     = null
}
