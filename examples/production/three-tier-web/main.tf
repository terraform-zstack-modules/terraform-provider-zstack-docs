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

locals {
  web_nodes = {
    for index in range(var.web_instance_count) :
    format("%s-web-%02d", var.name_prefix, index + 1) => index
  }

  app_nodes = {
    for index in range(var.app_instance_count) :
    format("%s-app-%02d", var.name_prefix, index + 1) => index
  }

  common_tag_targets = concat(
    [for vm in zstack_instance.web : vm.uuid],
    [for vm in zstack_instance.app : vm.uuid],
    [for volume in zstack_volume.app_data : volume.uuid],
    [zstack_vip.web.uuid, zstack_load_balancer.web.uuid]
  )
}

data "zstack_images" "app" {
  name = var.image_name
}

data "zstack_l3networks" "private" {
  name = var.private_l3_network_name
}

data "zstack_l3networks" "public" {
  name_pattern = var.public_l3_network_name_pattern
}

data "zstack_instance_offerings" "web" {
  name = var.web_instance_offering_name
}

data "zstack_instance_offerings" "app" {
  name = var.app_instance_offering_name
}

data "zstack_disk_offerings" "app_data" {
  name = var.app_disk_offering_name
}

resource "zstack_networking_secgroup" "web" {
  name         = "${var.name_prefix}-web-sg"
  description  = "Web tier ingress managed by Terraform"
  vswitch_type = var.vswitch_type
  ip_version   = 4
}

resource "zstack_networking_secgroup_rule" "web_http" {
  name                    = "http"
  security_group_uuid     = zstack_networking_secgroup.web.uuid
  direction               = "Ingress"
  action                  = "ACCEPT"
  protocol                = "TCP"
  priority                = 1
  ip_version              = 4
  ip_ranges               = var.web_ingress_cidr
  destination_port_ranges = tostring(var.web_port)
  description             = "Allow HTTP from approved clients"
  state                   = "Enabled"
}

resource "zstack_networking_secgroup" "app" {
  name         = "${var.name_prefix}-app-sg"
  description  = "Application tier ingress managed by Terraform"
  vswitch_type = var.vswitch_type
  ip_version   = 4
}

resource "zstack_networking_secgroup_rule" "app_from_web" {
  name                    = "app-from-web"
  security_group_uuid     = zstack_networking_secgroup.app.uuid
  direction               = "Ingress"
  action                  = "ACCEPT"
  protocol                = "TCP"
  priority                = 1
  ip_version              = 4
  ip_ranges               = var.app_ingress_cidr
  destination_port_ranges = tostring(var.app_port)
  description             = "Allow app traffic from the web tier CIDR"
  state                   = "Enabled"
}

resource "zstack_instance" "web" {
  for_each = local.web_nodes

  name                   = each.key
  description            = "Production reference web tier VM"
  image_uuid             = data.zstack_images.app.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.web.instance_offers[0].uuid
  expunge                = true

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.private.l3networks[0].uuid
      default_l3      = true
    }
  ]
}

resource "zstack_instance" "app" {
  for_each = local.app_nodes

  name                   = each.key
  description            = "Production reference application tier VM"
  image_uuid             = data.zstack_images.app.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.app.instance_offers[0].uuid
  expunge                = true

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.private.l3networks[0].uuid
      default_l3      = true
    }
  ]
}

resource "zstack_volume" "app_data" {
  for_each = zstack_instance.app

  name               = "${each.key}-data"
  description        = "Application data volume managed by Terraform"
  disk_offering_uuid = data.zstack_disk_offerings.app_data.disk_offers[0].uuid
  vm_instance_uuid   = each.value.uuid
}

resource "zstack_networking_secgroup_attachment" "web" {
  for_each = zstack_instance.web

  secgroup_uuid = zstack_networking_secgroup.web.uuid
  nic_uuid      = each.value.vm_nics[0].uuid
}

resource "zstack_networking_secgroup_attachment" "app" {
  for_each = zstack_instance.app

  secgroup_uuid = zstack_networking_secgroup.app.uuid
  nic_uuid      = each.value.vm_nics[0].uuid
}

resource "zstack_vip" "web" {
  name            = "${var.name_prefix}-web-vip"
  description     = "VIP for the production reference web entry"
  l3_network_uuid = data.zstack_l3networks.public.l3networks[0].uuid
}

resource "zstack_load_balancer" "web" {
  name        = "${var.name_prefix}-web-lb"
  description = "Production reference web load balancer"
  vip_uuid    = zstack_vip.web.uuid
}

resource "zstack_lb_server_group" "web" {
  name               = "${var.name_prefix}-web-backends"
  description        = "Backend server group for the web tier"
  load_balancer_uuid = zstack_load_balancer.web.uuid
  ip_version         = 4
}

resource "zstack_load_balancer_listener" "http" {
  name               = "${var.name_prefix}-http"
  description        = "HTTP listener for the production reference web entry"
  load_balancer_uuid = zstack_load_balancer.web.uuid
  protocol           = "http"
  load_balancer_port = var.web_port
  instance_port      = var.web_port
}

resource "zstack_tag" "environment" {
  name        = "${var.name_prefix}-environment"
  description = "Environment tag managed by Terraform"
  value       = var.environment
  color       = "#57D355"
  type        = "simple"
}

resource "zstack_tag" "application" {
  name        = "${var.name_prefix}-application"
  description = "Application tag managed by Terraform"
  value       = var.application
  color       = "#4D9DE0"
  type        = "simple"
}

resource "zstack_tag" "owner" {
  name        = "${var.name_prefix}-owner"
  description = "Owner tag managed by Terraform"
  value       = var.owner
  color       = "#F2C14E"
  type        = "simple"
}

resource "zstack_tag_attachment" "environment" {
  tag_uuid       = zstack_tag.environment.uuid
  resource_uuids = local.common_tag_targets
}

resource "zstack_tag_attachment" "application" {
  tag_uuid       = zstack_tag.application.uuid
  resource_uuids = local.common_tag_targets
}

resource "zstack_tag_attachment" "owner" {
  tag_uuid       = zstack_tag.owner.uuid
  resource_uuids = local.common_tag_targets
}
