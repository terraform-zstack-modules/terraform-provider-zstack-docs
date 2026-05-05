# Networking

ZStack networking examples cover L2/L3 network inputs, static IPs, security
groups, VIP/EIP, VPC, and routing.

## VM Network Interfaces

Use `network_interfaces` in `zstack_instance`:

- `l3_network_uuid` selects the L3 network.
- `default_l3` marks the default NIC.
- `static_ip` can be set when a fixed IP is required.

## Security Group

Security group workflow:

1. Create `zstack_networking_secgroup`.
2. Add `zstack_networking_secgroup_rule`.
3. Attach the group to a VM NIC with
   `zstack_networking_secgroup_attachment`.

See `examples/common/06-security-group`.

## VIP And EIP

Use `zstack_vip` and `zstack_eip` to expose a VM NIC through a public network.
Confirm the public L3 network UUID and VM NIC UUID before applying.

See `examples/common/05-eip`.

## VPC And Routing

VPC and routing examples include VPC network, route table, and route entry
resources. Association details depend on the customer network design and must be
validated in the environment.

See `examples/common/07-vpc` and `examples/common/12-vpc-routing`.
