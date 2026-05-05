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

resource "zstack_tag" "environment" {
  name        = var.tag_name
  description = var.tag_description
  value       = var.tag_value
  color       = var.tag_color
  type        = "simple"
}

resource "zstack_tag_attachment" "resources" {
  tag_uuid       = zstack_tag.environment.uuid
  resource_uuids = var.resource_uuids
}

output "tag_uuid" {
  description = "Created tag UUID."
  value       = zstack_tag.environment.uuid
}

output "tag_attachment" {
  description = "Tag attachment result."
  value       = zstack_tag_attachment.resources
}
