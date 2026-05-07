# 查询已有资源

Terraform 创建 VM、数据盘、安全组绑定、EIP 等资源前，通常需要先查询 ZStack 中已有的基础资源。

P0 优先掌握这些 data source：

- `zstack_images`
- `zstack_l3networks`
- `zstack_instance_offerings`
- `zstack_disk_offerings`
- `zstack_zone`
- `zstack_clusters`
- `zstack_hosts`
- `zstack_l2networks`
- `zstack_virtual_routers`
- `zstack_instances`

## 查询方式选择

| 方式 | 适用场景 | 建议 |
|---|---|---|
| `uuid` | 自动化、AI 生成、CI/CD、资源 UUID 已知 | 最稳定，优先使用 |
| `name` | 人工编写、名称唯一 | 常用于客户示例 |
| `name_pattern` | 模糊查找、探索环境 | 谨慎使用，必须检查结果 |
| `filter` | 按状态、类型、架构等字段筛选 | 适合缩小候选集 |

## 示例

首次验证环境时，可以只加载根目录 `.env` 中的鉴权变量，然后运行
`examples/common/02-query-existing-resources`。该 example 默认使用
`name_pattern = "%"` 做发现查询，并输出候选资源列表。

```hcl
data "zstack_images" "ubuntu" {
  name = var.image_name
}

data "zstack_l3networks" "default" {
  name = var.l3_network_name
}

data "zstack_instance_offerings" "small" {
  name = var.instance_offering_name
}
```

## 自动化建议

如果 agent 或脚本已经拿到 UUID，应直接生成：

```hcl
data "zstack_l3networks" "selected" {
  uuid = var.l3_network_uuid
}
```

避免 agent 随意编写宽泛的 `name_pattern = "%Ubuntu%"`，这可能匹配多个镜像并导致不可预测的选择。

## 对应 Example

见 `examples/common/02-query-existing-resources`。
