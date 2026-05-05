# 创建云主机

创建 VM 是 P0 的主线。最小依赖包括：

- 镜像 UUID。
- L3 网络 UUID。
- 计算规格 UUID，或直接指定 `cpu_num` + `memory_size`。
- 可选：root disk、静态 IP、多网卡、host/cluster/zone 放置策略、user data。

## 推荐流程

1. Query image, network, and offering by name.
2. Build VM inputs in `locals`.
3. Create one VM with `zstack_instance`.
4. Output VM UUID, name, and IP address.

## 网络配置

新配置应使用 `network_interfaces`：

```hcl
resource "zstack_instance" "vm" {
  name                   = var.vm_name
  image_uuid             = data.zstack_images.image.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.offering.instance_offers[0].uuid

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
      default_l3      = true
      static_ip       = var.static_ip
    }
  ]
}
```

不要把旧的 `l3_network_uuids` 作为新示例的推荐写法。

## 批量 VM

批量创建优先使用 `for_each`，并用 VM 名称作为稳定 key。这样后续增加或删除单台 VM 时，不会因为索引变化导致无关 VM 被替换。

## 初始化脚本

P1 场景中，VM 创建后常需要执行初始化脚本。相关资源：

- `zstack_ssh_key_pair`
- `zstack_instance_scripts`
- `zstack_instance_scripts_execution`

初始化脚本适合安装包、配置 agent、写入基础配置。脚本内容和超时时间应参数化，不要把敏感信息写进脚本文本。

## 对应 Examples

- `examples/common/03-create-vm`
- `examples/common/04-create-10-vms`
- `examples/common/13-vm-init-scripts`
