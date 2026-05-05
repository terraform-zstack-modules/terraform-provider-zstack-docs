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

locals {
  stack_template_content = jsonencode({
    ZStackTemplateFormatVersion = "2018-06-18"
    Resources                   = {}
  })
}

resource "zstack_stack_template" "template" {
  name             = var.stack_template_name
  description      = "Stack template managed by Terraform"
  template_content = local.stack_template_content
  type             = var.stack_template_type
}

resource "zstack_resource_stack" "stack" {
  name          = var.resource_stack_name
  description   = "Resource stack managed by Terraform"
  template_uuid = zstack_stack_template.template.uuid
  parameters    = var.stack_parameters
  rollback      = var.rollback
  type          = var.resource_stack_type
}

resource "zstack_preconfiguration_template" "preconfig" {
  name         = var.preconfiguration_template_name
  description  = "Preconfiguration template managed by Terraform"
  type         = var.preconfiguration_template_type
  distribution = var.preconfiguration_distribution
  content      = var.preconfiguration_content
}

output "stack_template_uuid" {
  value = zstack_stack_template.template.uuid
}

output "resource_stack_uuid" {
  value = zstack_resource_stack.stack.uuid
}

output "preconfiguration_template_uuid" {
  value = zstack_preconfiguration_template.preconfig.uuid
}
