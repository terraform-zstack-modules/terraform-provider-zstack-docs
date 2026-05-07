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

data "zstack_images" "existing" {
  name = var.existing_image_name

  filter {
    name   = "status"
    values = ["Ready"]
  }

  filter {
    name   = "state"
    values = ["Enabled"]
  }
}

resource "zstack_image" "managed" {
  count = var.create_image ? 1 : 0

  name                 = var.new_image_name
  description          = "Image managed by Terraform"
  url                  = var.new_image_url
  backup_storage_uuids = [var.backup_storage_uuid]
  format               = var.new_image_format
  platform             = var.new_image_platform
  guest_os_type        = var.new_image_guest_os_type
  architecture         = var.new_image_architecture
  boot_mode            = var.new_image_boot_mode
  expunge              = true
}

output "existing_images" {
  description = "Existing images matching the requested name."
  value       = data.zstack_images.existing.images
}

output "managed_image_uuid" {
  description = "Created image UUID when create_image is true."
  value       = try(zstack_image.managed[0].uuid, null)
}
