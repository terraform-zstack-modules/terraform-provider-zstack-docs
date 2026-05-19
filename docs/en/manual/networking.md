# Networking

The networking chapter prioritizes the capabilities most commonly used when
creating VMs: L3 lookup, VM NICs, static IP, security groups, VIP/EIP.

## VM Network Interfaces

`zstack_instance` uses `network_interfaces` to configure NICs:

```hcl
network_interfaces = [
  {
    l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
    default_l3      = true
    static_ip       = var.static_ip
  }
]
```

`l3_network_uuid` is required. `default_l3` and `static_ip` are optional:
single-NIC scenarios usually can omit `default_l3`; set `static_ip` only when a
fixed address is required. When `static_ip` is omitted, ZStack allocates the
address automatically. If the value is passed through a variable, set the
variable default to `null` so Terraform treats it as unset.

## Network Foundations

Most VM examples only query existing L3 networks. Create L2, L3, IP range, VPC,
or routing resources only when Terraform should manage network infrastructure;
these values usually require network administrator confirmation.

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_l2networks` | data source | Query existing L2 networks for L3 networks, VPC, or advanced network resources. |
| `zstack_l3networks` | data source | Query existing L3 networks for VM NICs, VIP/EIP, load balancer, and related resources. |
| `zstack_virtual_routers` | data source | Query virtual routers for VPC, route tables, and route entries. |
| `zstack_l2vlan_network` | resource | Create VLAN L2 networks; usually requires physical network, VLAN ID, and layer-2 planning. |
| `zstack_l3network` | resource | Create L3 networks; usually depends on L2 network and address range planning. |
| `zstack_subnet_ip_range` | resource | Configure subnet/IP address ranges and allocatable address ranges. |
| `zstack_reserved_ip` | resource | Reserve a specific IP to avoid automatic assignment to VMs or other resources. |
| `zstack_vpc` | resource | Create a VPC network that provides isolated private network space. |

## Security Group

Common security group resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_networking_secgroup` | resource | Create a security group container that carries inbound and outbound rules. |
| `zstack_networking_secgroup_rule` | resource | Create a security group rule with direction, protocol, port, CIDR, priority, and action. |
| `zstack_networking_secgroup_attachment` | resource | Attach a security group to a VM NIC so rules apply to that NIC. |

Security group rules should explicitly set direction, protocol, port, CIDR,
priority, and state. As a secure default, examples do not allow IPv4
`0.0.0.0/0` as an ingress CIDR. Use an explicit trusted CIDR such as bastion,
office, or business network. If public ingress is truly required, handle it
through separate network and security approval before adjusting the rule.

## VIP And EIP

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vip` | resource | Request a VIP on a specified L3 network as an EIP or load balancer entry address. |
| `zstack_eip` | resource | Bind a VIP to a VM NIC and expose services on that NIC. |

EIP binding requires VIP UUID and VM NIC UUID.

## VPC And Routing

VPC depends on L2 network, virtual router, and subnet planning, and is strongly
environment-dependent. A basic VPC scenario usually includes route table and
route entry:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vpc` | resource | Create a VPC network that provides isolated private network space. |
| `zstack_vrouter_route_table` | resource | Create a virtual router route table for custom routes. |
| `zstack_vrouter_route_entry` | resource | Create a route entry with destination CIDR and next hop/target. |

Before production use, confirm how the route table is associated with the
virtual router or VPC.

## Related Examples

- [examples/common/03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm)
- [examples/common/04-create-10-vms](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms)
- [examples/common/05-eip](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip)
- [examples/common/06-security-group](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group)
- [examples/common/07-vpc](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/07-vpc)
- [examples/common/12-vpc-routing](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing)
