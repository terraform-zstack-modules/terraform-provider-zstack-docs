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

data "zstack_images" "selected" {
  name_pattern = var.image_name_pattern
}

data "zstack_l3networks" "selected" {
  name_pattern = var.l3_network_name_pattern
}

data "zstack_instance_offerings" "selected" {
  name_pattern = var.instance_offering_name_pattern
}

data "zstack_disk_offerings" "selected" {
  name_pattern = var.disk_offering_name_pattern
}

data "zstack_zone" "selected" {
  name_pattern = var.zone_name_pattern
}

data "zstack_clusters" "selected" {
  name_pattern = var.cluster_name_pattern
}

data "zstack_hosts" "selected" {
  name_pattern = var.host_name_pattern
}

output "images" {
  description = "Images matching the discovery pattern."
  value       = data.zstack_images.selected.images
}

output "l3_networks" {
  description = "L3 networks matching the discovery pattern."
  value       = data.zstack_l3networks.selected.l3networks
}

output "instance_offerings" {
  description = "Instance offerings matching the discovery pattern."
  value       = data.zstack_instance_offerings.selected.instance_offers
}

output "disk_offerings" {
  description = "Disk offerings matching the discovery pattern."
  value       = data.zstack_disk_offerings.selected.disk_offers
}

output "zones" {
  description = "Zones matching the discovery pattern."
  value       = data.zstack_zone.selected.zones
}

output "clusters" {
  description = "Clusters matching the discovery pattern."
  value       = data.zstack_clusters.selected.clusters
}

output "hosts" {
  description = "Hosts matching the discovery pattern."
  value       = data.zstack_hosts.selected.hosts
}
