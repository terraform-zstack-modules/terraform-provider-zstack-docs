# 网络

网络章节优先覆盖创建 VM 时最常用的能力：L3 查询、VM NIC、静态 IP、安全组、VIP/EIP。

## VM 网卡

`zstack_instance` 使用 `network_interfaces` 配置 NIC：

```hcl
network_interfaces = [
  {
    l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
    default_l3      = true
    static_ip       = var.static_ip
  }
]
```

`l3_network_uuid` 是必填绑定。`default_l3` 和 `static_ip` 是可选字段：
单网卡场景通常可以省略 `default_l3`；需要固定地址时再设置 `static_ip`，
省略 `static_ip` 时由 ZStack 自动分配。通过变量透传时，可把变量默认值设为
`null`，让 Terraform 按未设置处理。

## 网络基础资源

多数 VM 示例只查询已有 L3 网络。只有在需要由 Terraform 纳管网络基础设施时，
才创建 L2、L3、IP range、VPC 或路由资源；这些值通常需要网络管理员提前确认。

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_l2networks` | data source | 查询已有 L2 网络，给 L3 网络、VPC 或高级网络资源选择底层网络。 |
| `zstack_l3networks` | data source | 查询已有 L3 网络，给 VM 网卡、VIP/EIP、负载均衡等资源选择网络 UUID。 |
| `zstack_virtual_routers` | data source | 查询虚拟路由器，给 VPC、路由表和路由条目选择路由器上下文。 |
| `zstack_l2vlan_network` | resource | 创建 VLAN 类型 L2 网络，通常需要物理网络、VLAN ID 和二层规划。 |
| `zstack_l3network` | resource | 创建 L3 网络，通常依赖 L2 网络和地址段规划。 |
| `zstack_subnet_ip_range` | resource | 为网络配置子网/IP 地址段，定义可分配地址范围。 |
| `zstack_reserved_ip` | resource | 预留指定 IP，避免被自动分配给 VM 或其他资源。 |
| `zstack_vpc` | resource | 创建 VPC 网络，提供隔离的私有网络空间。 |

## 安全组

常用安全组资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_networking_secgroup` | resource | 创建安全组容器，承载一组出入方向规则。 |
| `zstack_networking_secgroup_rule` | resource | 创建安全组规则，定义方向、协议、端口、CIDR、优先级和动作。 |
| `zstack_networking_secgroup_attachment` | resource | 把安全组绑定到 VM NIC，使规则对该网卡生效。 |

安全组规则应显式写出方向、协议、端口、CIDR、优先级和状态。出于安全默认，
示例不允许把入口 CIDR 配置为 IPv4 `0.0.0.0/0`。请使用明确的可信网段，
例如堡垒机、办公网或业务网段；确需公网放通时，应单独走网络和安全审批后
再调整规则。

## VIP/EIP

常用资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_vip` | resource | 在指定 L3 网络上申请 VIP，作为 EIP 或负载均衡入口地址。 |
| `zstack_eip` | resource | 将 VIP 绑定到 VM NIC，对外暴露该网卡服务。 |

EIP 绑定需要 VIP UUID 和 VM NIC UUID。

## VPC 与路由

VPC 依赖 L2 网络、虚拟路由器和子网规划，环境依赖强。基础 VPC 场景通常包含 route table 和 route entry：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_vpc` | resource | 创建 VPC 网络，提供隔离的私有网络空间。 |
| `zstack_vrouter_route_table` | resource | 创建虚拟路由器路由表，用于承载自定义路由。 |
| `zstack_vrouter_route_entry` | resource | 创建路由条目，定义目标 CIDR 和下一跳/目标。 |

生产使用前需要确认 route table 与虚拟路由器/VPC 的关联方式。

## 对应示例

- [examples/common/03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm)
- [examples/common/04-create-10-vms](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms)
- [examples/common/05-eip](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip)
- [examples/common/06-security-group](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group)
- [examples/common/07-vpc](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/07-vpc)
- [examples/common/12-vpc-routing](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing)
