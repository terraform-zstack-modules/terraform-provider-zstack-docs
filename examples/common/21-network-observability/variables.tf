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

variable "flow_meter_name" {
  description = "Name of the flow meter to create or query."
  default     = "tf-flow-meter"
}

variable "flow_meter_type" {
  description = "Type value for the flow meter."
  type        = string
}

variable "flow_meter_server" {
  description = "Input value for flow meter server."
  type        = string
}

variable "flow_meter_port" {
  description = "Port number for the flow meter."
  type        = number
}

variable "flow_meter_version" {
  description = "Input value for flow meter version."
  default     = "5"
}

variable "flow_meter_sample" {
  description = "Input value for flow meter sample."
  default     = 1
}

variable "flow_meter_generate_interval" {
  description = "Interval value for the flow meter generate interval."
  default     = 60
}

variable "flow_collector_name" {
  description = "Name of the flow collector to create or query."
  default     = "tf-flow-collector"
}

variable "flow_collector_server" {
  description = "Input value for flow collector server."
  type        = string
}

variable "flow_collector_port" {
  description = "Port number for the flow collector."
  type        = number
}

variable "port_mirror_name" {
  description = "Name of the port mirror to create or query."
  default     = "tf-port-mirror"
}

variable "mirror_network_uuid" {
  description = "UUID of the mirror network to use in this example."
  type        = string
}

variable "port_mirror_session_name" {
  description = "Name of the port mirror session to create or query."
  default     = "tf-port-mirror-session"
}

variable "port_mirror_session_type" {
  description = "Type value for the port mirror session."
  type        = string
}

variable "src_end_point" {
  description = "Input value for src end point."
  type        = string
}

variable "dst_end_point" {
  description = "Input value for dst end point."
  type        = string
}
