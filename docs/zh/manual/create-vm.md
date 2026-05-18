# 创建云主机

创建 VM 是最常见的入门场景。最小依赖包括：

- 镜像 UUID。
- L3 网络 UUID。
- 计算规格 UUID，或直接指定 `cpu_num` + `memory_size`。
- 可选：root disk、静态 IP、多网卡、host/cluster/zone 放置策略、user data。

## 推荐流程

1. 按名称或 UUID 查询镜像、L3 网络和计算规格。
2. 在 `locals` 中整理 VM 输入参数。
3. 使用 `zstack_instance` 创建单台 VM。
4. 输出 VM UUID、名称和 IP 地址，便于后续排障。

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

`l3_network_uuid` 是网卡必须关联的 L3 网络。`default_l3` 和 `static_ip`
都是可选字段：单网卡场景通常可以省略 `default_l3`；需要固定 IP 时再设置
`static_ip`。省略 `static_ip` 时由 ZStack 自动分配地址；如果像示例一样通过
变量透传，变量默认值设为 `null` 可以让 Terraform 按未设置处理。

不要把旧的 `l3_network_uuids` 作为新示例的推荐写法。

## 批量 VM

批量创建优先使用 `for_each`，并用 VM 名称作为稳定 key。这样后续增加或删除单台 VM 时，不会因为索引变化导致无关 VM 被替换。

## 初始化脚本

进阶场景中，VM 创建后常需要执行初始化脚本。相关资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_ssh_key_pair` | resource | 创建 SSH 密钥对，供 VM 登录或初始化脚本执行使用。 |
| `zstack_instance_scripts` | resource | 创建实例脚本定义，保存要在 VM 内执行的脚本内容和类型。 |
| `zstack_instance_scripts_execution` | resource | 创建脚本执行记录，把脚本应用到指定 VM。 |

初始化脚本适合安装包、配置 guest agent、写入基础配置。脚本内容和超时时间应参数化，不要把敏感信息写进脚本文本。

## 对应示例

- [examples/common/03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm)
- [examples/common/04-create-10-vms](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms)
- [examples/common/13-vm-init-scripts](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/13-vm-init-scripts)
