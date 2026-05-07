terraform {
  required_version = ">= 1.5"

  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.3"
    }
  }
}

provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}

data "zstack_l3networks" "public" {
  name_pattern = var.public_l3_network_name_pattern
}

resource "zstack_vip" "web" {
  name            = var.vip_name
  description     = "VIP for Terraform-managed web load balancer"
  l3_network_uuid = data.zstack_l3networks.public.l3networks[0].uuid
}

resource "zstack_load_balancer" "web" {
  name        = var.load_balancer_name
  description = "Web load balancer managed by Terraform"
  vip_uuid    = zstack_vip.web.uuid
}

resource "zstack_lb_server_group" "web" {
  name               = var.server_group_name
  description        = "Backend server group for web traffic"
  load_balancer_uuid = zstack_load_balancer.web.uuid
  ip_version         = 4
}

resource "zstack_load_balancer_listener" "http" {
  name               = var.listener_name
  description        = "Forward HTTP traffic to backend web instances"
  load_balancer_uuid = zstack_load_balancer.web.uuid
  protocol           = "http"
  load_balancer_port = var.frontend_port
  instance_port      = var.backend_port
}

output "vip_uuid" {
  description = "VIP UUID."
  value       = zstack_vip.web.uuid
}

output "selected_public_l3_network" {
  description = "Public L3 network selected by the data source."
  value       = data.zstack_l3networks.public.l3networks[0]
}

output "load_balancer_uuid" {
  description = "Load balancer UUID."
  value       = zstack_load_balancer.web.uuid
}

output "listener_uuid" {
  description = "HTTP listener UUID."
  value       = zstack_load_balancer_listener.http.uuid
}

output "server_group_uuid" {
  description = "Server group UUID."
  value       = zstack_lb_server_group.web.uuid
}
