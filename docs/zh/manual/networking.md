# 网络

P0 网络文档优先覆盖客户创建 VM 时最常用的网络能力：L3 查询、VM NIC、静态 IP、安全组、VIP/EIP。

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

`static_ip = null` 时由 ZStack 自动分配。

## 安全组

P0 安全组资源：

- `zstack_networking_secgroup`
- `zstack_networking_secgroup_rule`
- `zstack_networking_secgroup_attachment`

安全组规则应显式写出方向、协议、端口、CIDR、优先级和状态。

## VIP/EIP

P1 场景中常用：

- `zstack_vip`
- `zstack_eip`

EIP 绑定需要 VIP UUID 和 VM NIC UUID。

## VPC

VPC 依赖 L2 网络、虚拟路由器和子网规划，环境依赖强。P1 中先覆盖基础 VPC、route table 和 route entry：

- `zstack_vpc`
- `zstack_vrouter_route_table`
- `zstack_vrouter_route_entry`

生产使用前需要确认 route table 与虚拟路由器/VPC 的关联方式。

## 对应 Examples

- `examples/common/03-create-vm`
- `examples/common/04-create-10-vms`
- `examples/common/05-eip`
- `examples/common/06-security-group`
- `examples/common/07-vpc`
- `examples/common/12-vpc-routing`
