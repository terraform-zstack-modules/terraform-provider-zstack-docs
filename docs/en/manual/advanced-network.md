# Advanced Network

Advanced network scenarios include IPsec and policy route resources.

Common resources:

- `zstack_ipsec_connection`
- `zstack_policy_route_rule_set`
- `zstack_policy_route_rule`

## IPsec

Confirm VIP, peer address, authentication key, encryption algorithms, PFS, and
transform protocol with the peer side. Keep authentication keys sensitive.

## Policy Route

Confirm vRouter UUID, route table UUID, rule number, source and destination
matching fields, and protocol before applying.
When `protocol` is set, use the uppercase values accepted by the provider
schema: `TCP`, `UDP`, or `ICMP`.

See `examples/common/22-advanced-network`.
