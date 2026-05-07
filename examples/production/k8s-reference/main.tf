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
  control_plane_nodes = {
    for index in range(var.control_plane_count) :
    format("%s-cp-%02d", var.cluster_name, index + 1) => index
  }

  worker_nodes = {
    for index in range(var.worker_count) :
    format("%s-worker-%02d", var.cluster_name, index + 1) => index
  }

  node_uuids = concat(
    [for vm in zstack_instance.control_plane : vm.uuid],
    [for vm in zstack_instance.worker : vm.uuid]
  )
}

data "zstack_images" "node" {
  name = var.node_image_name
}

data "zstack_l3networks" "private" {
  name = var.private_l3_network_name
}

data "zstack_l3networks" "public" {
  name_pattern = var.public_l3_network_name_pattern
}

data "zstack_instance_offerings" "control_plane" {
  name = var.control_plane_offering_name
}

data "zstack_instance_offerings" "worker" {
  name = var.worker_offering_name
}

resource "zstack_networking_secgroup" "cluster" {
  name         = "${var.cluster_name}-nodes-sg"
  description  = "Kubernetes node security group managed by Terraform"
  vswitch_type = var.vswitch_type
  ip_version   = 4
}

resource "zstack_networking_secgroup_rule" "api" {
  name                    = "kube-apiserver"
  security_group_uuid     = zstack_networking_secgroup.cluster.uuid
  direction               = "Ingress"
  action                  = "ACCEPT"
  protocol                = "TCP"
  priority                = 1
  ip_version              = 4
  ip_ranges               = var.api_allowed_cidr
  destination_port_ranges = "6443"
  description             = "Allow Kubernetes API access"
  state                   = "Enabled"
}

resource "zstack_networking_secgroup_rule" "node_internal" {
  name                    = "node-internal"
  security_group_uuid     = zstack_networking_secgroup.cluster.uuid
  direction               = "Ingress"
  action                  = "ACCEPT"
  protocol                = "TCP"
  priority                = 2
  ip_version              = 4
  ip_ranges               = var.node_internal_cidr
  destination_port_ranges = "10250,30000-32767"
  description             = "Allow kubelet and NodePort traffic inside the node network"
  state                   = "Enabled"
}

resource "zstack_instance" "control_plane" {
  for_each = local.control_plane_nodes

  name                   = each.key
  description            = "Kubernetes control-plane node infrastructure"
  image_uuid             = data.zstack_images.node.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.control_plane.instance_offers[0].uuid
  expunge                = true

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.private.l3networks[0].uuid
      default_l3      = true
    }
  ]
}

resource "zstack_instance" "worker" {
  for_each = local.worker_nodes

  name                   = each.key
  description            = "Kubernetes worker node infrastructure"
  image_uuid             = data.zstack_images.node.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.worker.instance_offers[0].uuid
  expunge                = true

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.private.l3networks[0].uuid
      default_l3      = true
    }
  ]
}

resource "zstack_networking_secgroup_attachment" "control_plane" {
  for_each = zstack_instance.control_plane

  secgroup_uuid = zstack_networking_secgroup.cluster.uuid
  nic_uuid      = each.value.vm_nics[0].uuid
}

resource "zstack_networking_secgroup_attachment" "worker" {
  for_each = zstack_instance.worker

  secgroup_uuid = zstack_networking_secgroup.cluster.uuid
  nic_uuid      = each.value.vm_nics[0].uuid
}

resource "zstack_vip" "api" {
  name            = "${var.cluster_name}-api-vip"
  description     = "VIP for Kubernetes API endpoint"
  l3_network_uuid = data.zstack_l3networks.public.l3networks[0].uuid
}

resource "zstack_load_balancer" "api" {
  name        = "${var.cluster_name}-api-lb"
  description = "Kubernetes API load balancer"
  vip_uuid    = zstack_vip.api.uuid
}

resource "zstack_lb_server_group" "api" {
  name               = "${var.cluster_name}-api-backends"
  description        = "Kubernetes API server group"
  load_balancer_uuid = zstack_load_balancer.api.uuid
  ip_version         = 4
}

resource "zstack_load_balancer_listener" "api" {
  name               = "${var.cluster_name}-api"
  description        = "Kubernetes API listener"
  load_balancer_uuid = zstack_load_balancer.api.uuid
  protocol           = "tcp"
  load_balancer_port = 6443
  instance_port      = 6443
}

resource "zstack_tag" "cluster" {
  name        = "${var.cluster_name}-cluster"
  description = "Kubernetes cluster tag managed by Terraform"
  value       = var.cluster_name
  color       = "#4D9DE0"
  type        = "simple"
}

resource "zstack_tag_attachment" "cluster" {
  tag_uuid       = zstack_tag.cluster.uuid
  resource_uuids = local.node_uuids
}
