# Advanced Network

Advanced networking covers site-to-site connectivity and policy routing. These
configurations strongly depend on network planning. Do not invent peer
addresses, keys, route tables, or policy values.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_ipsec_connection` | resource | Create an IPsec site-to-site connection, configuring VIP, peer address, and auth key. |
| `zstack_policy_route_rule_set` | resource | Create a policy route rule set to organize a group of policy route rules. |
| `zstack_policy_route_rule` | resource | Create a policy route rule, matching source/destination address, protocol, and route table. |

## IPsec

```hcl
resource "zstack_ipsec_connection" "site_to_site" {
  name         = var.ipsec_name
  vip_uuid     = var.vip_uuid
  peer_address = var.peer_address
  auth_key     = var.auth_key
}
```

`auth_key` is sensitive and should be passed through a sensitive variable.

## Policy Route

Policy routing consists of a rule set and rules. Each rule needs a route table:

```hcl
resource "zstack_policy_route_rule" "main" {
  rule_set_uuid = zstack_policy_route_rule_set.main.uuid
  table_uuid    = var.route_table_uuid
  rule_number   = var.rule_number
  dest_ip       = var.dest_ip
}
```

If `protocol` is set, use uppercase values accepted by the provider schema:
`TCP`, `UDP`, or `ICMP`.

Related example:
[examples/common/22-advanced-network](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/22-advanced-network).
