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

variable "flow_meter_name" { default = "tf-flow-meter" }
variable "flow_meter_type" { type = string }
variable "flow_meter_server" { type = string }
variable "flow_meter_port" { type = number }
variable "flow_meter_version" { default = "5" }
variable "flow_meter_sample" { default = 1 }
variable "flow_meter_generate_interval" { default = 60 }

variable "flow_collector_name" { default = "tf-flow-collector" }
variable "flow_collector_server" { type = string }
variable "flow_collector_port" { type = number }

variable "port_mirror_name" { default = "tf-port-mirror" }
variable "mirror_network_uuid" { type = string }
variable "port_mirror_session_name" { default = "tf-port-mirror-session" }
variable "port_mirror_session_type" { type = string }
variable "src_end_point" { type = string }
variable "dst_end_point" { type = string }
