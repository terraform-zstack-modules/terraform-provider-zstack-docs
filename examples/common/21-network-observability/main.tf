terraform {
  required_version = ">= 1.5"

  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.2"
    }
  }
}

provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}

resource "zstack_flow_meter" "netflow" {
  name              = var.flow_meter_name
  description       = "Flow meter managed by Terraform"
  type              = var.flow_meter_type
  server            = var.flow_meter_server
  port              = var.flow_meter_port
  version           = var.flow_meter_version
  sample            = var.flow_meter_sample
  generate_interval = var.flow_meter_generate_interval
}

resource "zstack_flow_collector" "collector" {
  name            = var.flow_collector_name
  description     = "Flow collector managed by Terraform"
  flow_meter_uuid = zstack_flow_meter.netflow.uuid
  server          = var.flow_collector_server
  port            = var.flow_collector_port
}

resource "zstack_port_mirror" "mirror" {
  name                = var.port_mirror_name
  description         = "Port mirror managed by Terraform"
  mirror_network_uuid = var.mirror_network_uuid
}

resource "zstack_port_mirror_session" "session" {
  name             = var.port_mirror_session_name
  description      = "Port mirror session managed by Terraform"
  port_mirror_uuid = zstack_port_mirror.mirror.uuid
  type             = var.port_mirror_session_type
  src_end_point    = var.src_end_point
  dst_end_point    = var.dst_end_point
}

output "flow_meter_uuid" {
  value = zstack_flow_meter.netflow.uuid
}

output "flow_collector_uuid" {
  value = zstack_flow_collector.collector.uuid
}

output "port_mirror_uuid" {
  value = zstack_port_mirror.mirror.uuid
}

output "port_mirror_session_uuid" {
  value = zstack_port_mirror_session.session.uuid
}
