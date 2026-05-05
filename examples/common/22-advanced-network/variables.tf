variable "zstack_host" { type = string }
variable "zstack_port" {
  type    = number
  default = 8080
}
variable "zstack_access_key_id" { type = string }
variable "zstack_access_key_secret" {
  type      = string
  sensitive = true
}

variable "ipsec_name" { default = "tf-ipsec" }
variable "vip_uuid" { type = string }
variable "peer_address" { type = string }
variable "auth_key" {
  type      = string
  sensitive = true
}
variable "auth_mode" { default = "psk" }
variable "ike_auth_algorithm" { default = null }
variable "ike_encryption_algorithm" { default = null }
variable "policy_auth_algorithm" { default = null }
variable "policy_encryption_algorithm" { default = null }
variable "policy_mode" { default = null }
variable "transform_protocol" { default = null }
variable "pfs" { default = null }

variable "rule_set_name" { default = "tf-policy-route-set" }
variable "vrouter_uuid" { type = string }
variable "rule_set_type" { default = null }
variable "route_table_uuid" { type = string }
variable "rule_number" { default = 100 }
variable "source_ip" { default = null }
variable "source_port" { default = null }
variable "dest_ip" { default = null }
variable "dest_port" { default = null }
variable "protocol" { default = null }
