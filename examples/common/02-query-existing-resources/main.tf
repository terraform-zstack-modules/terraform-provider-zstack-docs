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

data "zstack_images" "selected" {
  name = var.image_name
}

data "zstack_l3networks" "selected" {
  name = var.l3_network_name
}

data "zstack_instance_offerings" "selected" {
  name = var.instance_offering_name
}

data "zstack_disk_offerings" "selected" {
  name = var.disk_offering_name
}

data "zstack_zone" "selected" {
  name = var.zone_name
}

data "zstack_clusters" "selected" {
  name = var.cluster_name
}

data "zstack_hosts" "selected" {
  name = var.host_name
}

output "images" {
  description = "Images matching the exact name."
  value       = data.zstack_images.selected.images
}

output "l3_networks" {
  description = "L3 networks matching the exact name."
  value       = data.zstack_l3networks.selected.l3networks
}

output "instance_offerings" {
  description = "Instance offerings matching the exact name."
  value       = data.zstack_instance_offerings.selected.instance_offers
}

output "disk_offerings" {
  description = "Disk offerings matching the exact name."
  value       = data.zstack_disk_offerings.selected.disk_offers
}

output "zones" {
  description = "Zones matching the exact name."
  value       = data.zstack_zone.selected.zones
}

output "clusters" {
  description = "Clusters matching the exact name."
  value       = data.zstack_clusters.selected.clusters
}

output "hosts" {
  description = "Hosts matching the exact name."
  value       = data.zstack_hosts.selected.hosts
}
