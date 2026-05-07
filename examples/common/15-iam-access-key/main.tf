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

resource "zstack_account" "automation" {
  name        = var.account_name
  password    = var.account_password
  description = "Automation account managed by Terraform"
}

resource "zstack_iam2_project" "project" {
  name        = var.project_name
  description = "IAM2 project managed by Terraform"
}

resource "zstack_iam2_virtual_id" "automation" {
  name        = var.virtual_id_name
  password    = var.virtual_id_password
  description = "IAM2 virtual ID managed by Terraform"
}

resource "zstack_access_key" "automation" {
  account_uuid = zstack_account.automation.uuid
  user_uuid    = zstack_account.automation.uuid
  description  = "AccessKey for Terraform automation"
}

output "account_uuid" {
  description = "Created account UUID."
  value       = zstack_account.automation.uuid
}

output "project_uuid" {
  description = "Created IAM2 project UUID."
  value       = zstack_iam2_project.project.uuid
}

output "virtual_id_uuid" {
  description = "Created IAM2 virtual ID UUID."
  value       = zstack_iam2_virtual_id.automation.uuid
}

output "access_key_id" {
  description = "Created AccessKey ID. Store securely."
  value       = zstack_access_key.automation.access_key_id
  sensitive   = true
}

output "access_key_secret" {
  description = "Created AccessKey Secret. Store securely."
  value       = zstack_access_key.automation.access_key_secret
  sensitive   = true
}
