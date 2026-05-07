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

resource "zstack_ipsec_connection" "site_to_site" {
  name                        = var.ipsec_name
  description                 = "IPsec connection managed by Terraform"
  vip_uuid                    = var.vip_uuid
  peer_address                = var.peer_address
  auth_key                    = var.auth_key
  auth_mode                   = var.auth_mode
  ike_auth_algorithm          = var.ike_auth_algorithm
  ike_encryption_algorithm    = var.ike_encryption_algorithm
  policy_auth_algorithm       = var.policy_auth_algorithm
  policy_encryption_algorithm = var.policy_encryption_algorithm
  policy_mode                 = var.policy_mode
  transform_protocol          = var.transform_protocol
  pfs                         = var.pfs
}

resource "zstack_policy_route_rule_set" "main" {
  name         = var.rule_set_name
  description  = "Policy route rule set managed by Terraform"
  vrouter_uuid = var.vrouter_uuid
  type         = var.rule_set_type
}

resource "zstack_policy_route_rule" "main" {
  rule_set_uuid = zstack_policy_route_rule_set.main.uuid
  table_uuid    = var.route_table_uuid
  rule_number   = var.rule_number
  source_ip     = var.source_ip
  source_port   = var.source_port
  dest_ip       = var.dest_ip
  dest_port     = var.dest_port
  protocol      = var.protocol
}

output "ipsec_connection_uuid" {
  value     = zstack_ipsec_connection.site_to_site.uuid
  sensitive = true
}

output "policy_route_rule_set_uuid" {
  value = zstack_policy_route_rule_set.main.uuid
}

output "policy_route_rule_uuid" {
  value = zstack_policy_route_rule.main.uuid
}
