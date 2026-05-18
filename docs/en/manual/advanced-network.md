# Advanced Network

Advanced network scenarios include IPsec and policy route resources.

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_ipsec_connection` | resource | Create an IPsec site-to-site connection with VIP, peer address, and authentication key. |
| `zstack_policy_route_rule_set` | resource | Create a policy route rule set that groups policy route rules. |
| `zstack_policy_route_rule` | resource | Create a policy route rule that matches source/destination/protocol fields and associates with a route table. |

## IPsec

Confirm VIP, peer address, authentication key, encryption algorithms, PFS, and
transform protocol with the peer side. Keep authentication keys sensitive.

## Policy Route

Confirm vRouter UUID, route table UUID, rule number, source and destination
matching fields, and protocol before applying.
When `protocol` is set, use the uppercase values accepted by the provider
schema: `TCP`, `UDP`, or `ICMP`.

See [examples/common/22-advanced-network](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/22-advanced-network).
