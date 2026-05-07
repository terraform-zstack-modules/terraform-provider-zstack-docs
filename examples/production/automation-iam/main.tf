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
  description = var.account_description
}

resource "zstack_iam2_project" "automation" {
  name        = var.project_name
  description = var.project_description
}

resource "zstack_iam2_virtual_id" "automation" {
  name        = var.virtual_id_name
  password    = var.virtual_id_password
  description = var.virtual_id_description
}

resource "zstack_access_key" "automation" {
  account_uuid = zstack_account.automation.uuid
  user_uuid    = zstack_account.automation.uuid
  description  = var.access_key_description
}
