# Networking

ZStack networking examples cover L2/L3 network inputs, static IPs, security
groups, VIP/EIP, VPC, and routing.

## VM Network Interfaces

Use `network_interfaces` in `zstack_instance`:

- `l3_network_uuid` is the required L3 network binding.
- `default_l3` is optional and marks the default NIC when needed. Single-NIC VMs
  usually do not need it.
- `static_ip` is optional. Set it only when a fixed IP is required; omit it or
  pass a variable whose default is `null` to let Terraform treat the argument as
  unset and allow ZStack to allocate the address.

## Network Foundations

Most VM examples query an existing L3 network. Create L2, L3, IP range, VPC, or
route resources only when Terraform is meant to manage network infrastructure;
these values usually need network administrator review first.

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_l2networks` | data source | Query existing L2 networks for L3, VPC, or advanced network workflows. |
| `zstack_l3networks` | data source | Query existing L3 networks for VM NICs, VIP/EIP, load balancers, and related resources. |
| `zstack_virtual_routers` | data source | Query virtual routers for VPC, route table, and route entry workflows. |
| `zstack_l2vlan_network` | resource | Create a VLAN L2 network, usually requiring physical network, VLAN ID, and L2 planning. |
| `zstack_l3network` | resource | Create an L3 network, usually based on an L2 network and address-range planning. |
| `zstack_subnet_ip_range` | resource | Configure subnet/IP ranges that define allocatable addresses. |
| `zstack_reserved_ip` | resource | Reserve specific IP addresses so they are not automatically assigned to VMs or other resources. |
| `zstack_vpc` | resource | Create an isolated VPC network. |

## Security Group

Security group workflow:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_networking_secgroup` | resource | Create a security group container for ingress or egress rules. |
| `zstack_networking_secgroup_rule` | resource | Create a security group rule with direction, protocol, ports, CIDR, priority, and action. |
| `zstack_networking_secgroup_attachment` | resource | Attach the security group to a VM NIC so the rules take effect. |

For a safer default, the example does not allow ingress CIDR `0.0.0.0/0`.
Use an explicit trusted CIDR such as a bastion, office, or application network.
If public ingress is required, handle it as a separate network and security
approval before changing the rule.

See [examples/common/06-security-group](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group).

## VIP And EIP

Use `zstack_vip` and `zstack_eip` to expose a VM NIC through a public network.
Confirm the public L3 network UUID and VM NIC UUID before applying.

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vip` | resource | Allocate a VIP on a selected L3 network for EIP or load balancer entry points. |
| `zstack_eip` | resource | Bind a VIP to a VM NIC to expose the NIC service externally. |

See [examples/common/05-eip](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip).

## VPC And Routing

VPC and routing examples include VPC network, route table, and route entry
resources. Association details depend on the customer network design and must be
validated in the environment.

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vpc` | resource | Create an isolated VPC network. |
| `zstack_vrouter_route_table` | resource | Create a virtual router route table for custom routes. |
| `zstack_vrouter_route_entry` | resource | Create a route entry with destination CIDR and route target. |

See [examples/common/07-vpc](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/07-vpc) and [examples/common/12-vpc-routing](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing).
