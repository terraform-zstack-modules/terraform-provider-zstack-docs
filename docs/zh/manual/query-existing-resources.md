# 查询已有资源

Terraform 创建 VM、数据盘、安全组绑定、VIP/EIP、LB、VPC 或管理员资源前，通常需要先查询 ZStack 中已有对象。本页列出 provider `1.1.3` 注册的全部 data source，并标出建议优先级和常用程度。

优先级说明：

- **基础优先**：第一次接入环境时优先掌握，VM 和多数示例都会依赖。
- **常用扩展**：网络、存储、安全组、脚本、标签等常见交付场景经常使用。
- **场景化**：只在对应功能场景中使用，例如 LB、端口转发、亲和组、自动伸缩。
- **管理员/专项**：平台管理员或专项能力使用，通常需要额外权限和变更评审。

## 全量 Data Source 索引

| Data source | 优先级 | 常用程度 | 用途 |
|---|---|---|---|
| `zstack_images` | 基础优先 | 高频 | 查询镜像，给 VM 创建或镜像管理流程选择 `image_uuid`。 |
| `zstack_l3networks` | 基础优先 | 高频 | 查询 L3 网络，给 VM 网卡、VIP/EIP、VPC 等网络资源选择网络 UUID。 |
| `zstack_instance_offerings` | 基础优先 | 高频 | 查询云主机计算规格，给 VM 选择 CPU/内存规格。 |
| `zstack_disk_offerings` | 基础优先 | 常用 | 查询云盘规格，给数据盘、镜像或备份相关流程选择磁盘规格。 |
| `zstack_zone` | 基础优先 | 常用 | 查询区域，确认资源所在的 ZStack zone。 |
| `zstack_clusters` | 基础优先 | 常用 | 查询集群，给放置策略或主机范围选择 cluster。 |
| `zstack_hosts` | 基础优先 | 常用 | 查询物理主机，给 host 放置或排障确认目标 host。 |
| `zstack_instances` | 常用扩展 | 常用 | 查询已有云主机，给 EIP 绑定、安全组附件、导入或排障选择 VM/NIC。 |
| `zstack_l2networks` | 常用扩展 | 常用 | 查询 L2 网络，给 L3、VPC 或高级网络场景选择底层网络。 |
| `zstack_virtual_routers` | 常用扩展 | 常用 | 查询虚拟路由器，给 VPC、路由表和路由条目选择路由器上下文。 |
| `zstack_vips` | 常用扩展 | 常用 | 查询 VIP，给 EIP、LB、端口转发或公网入口排障使用。 |
| `zstack_eips` | 常用扩展 | 常用 | 查询已有 EIP，给公网访问绑定、迁移或排障使用。 |
| `zstack_primary_storages` | 常用扩展 | 常用 | 查询主存储，确认容量、类型或资源放置上下文。 |
| `zstack_backup_storages` | 常用扩展 | 常用 | 查询镜像存储/备份存储，给 image、镜像导入、备份/CDP 流程使用。 |
| `zstack_volumes` | 常用扩展 | 常用 | 查询已有数据盘，给挂载、导入、快照或备份流程使用。 |
| `zstack_volume_snapshots` | 常用扩展 | 常用 | 查询云盘快照，给恢复、审计或快照管理流程使用。 |
| `zstack_networking_secgroups` | 常用扩展 | 常用 | 查询安全组，给 VM NIC 绑定或安全组治理使用。 |
| `zstack_networking_secgroup_rules` | 常用扩展 | 常用 | 查询安全组规则，给规则审计、迁移或冲突排查使用。 |
| `zstack_tags` | 常用扩展 | 常用 | 查询标签，给资源治理、成本归属或迁移校验使用。 |
| `zstack_user_tags` | 常用扩展 | 常用 | 查询用户标签，给业务元数据治理或迁移校验使用。 |
| `zstack_ssh_key_pairs` | 常用扩展 | 常用 | 查询 SSH key pair，给 VM 初始化或登录访问流程使用。 |
| `zstack_instance_scripts` | 常用扩展 | 常用 | 查询 VM 初始化/执行脚本，给 day-1 初始化和脚本执行排障使用。 |
| `zstack_accounts` | 场景化 | 按需 | 查询账号，给 IAM、权限边界或自动化账号治理使用。 |
| `zstack_iam2_projects` | 场景化 | 按需 | 查询 IAM2 project，给项目级权限和自动化身份场景使用。 |
| `zstack_affinity_groups` | 场景化 | 按需 | 查询亲和组，给 VM 放置策略或高可用部署使用。 |
| `zstack_auto_scaling_groups` | 场景化 | 按需 | 查询自动伸缩组，给弹性伸缩治理或排障使用。 |
| `zstack_disks` | 场景化 | 按需 | 查询磁盘对象，给存量磁盘审计或底层磁盘排查使用。 |
| `zstack_l2vlan_networks` | 场景化 | 按需 | 查询 VLAN L2 网络，给 VLAN 网络和 L3 网络建设使用。 |
| `zstack_reserved_ips` | 场景化 | 按需 | 查询保留 IP，给网络地址规划或冲突排查使用。 |
| `zstack_subnet_ip_ranges` | 场景化 | 按需 | 查询子网 IP 段，给 L3 网络地址池确认和规划使用。 |
| `zstack_load_balancers` | 场景化 | 按需 | 查询负载均衡实例，给 LB 迁移、绑定或排障使用。 |
| `zstack_load_balancer_listeners` | 场景化 | 按需 | 查询 LB listener，给端口监听、后端绑定或排障使用。 |
| `zstack_port_forwarding_rules` | 场景化 | 按需 | 查询端口转发规则，给公网入口迁移或冲突排查使用。 |
| `zstack_virtual_router_images` | 场景化 | 按需 | 查询虚拟路由器镜像，给 VPC/VR 基础资源建设使用。 |
| `zstack_virtual_router_offerings` | 场景化 | 按需 | 查询虚拟路由器规格，给 VPC/VR 资源建设使用。 |
| `zstack_global_configs` | 管理员/专项 | 受控 | 查询全局配置当前值和默认值，给受控管理员变更使用。 |
| `zstack_license_authorized_capacity` | 管理员/专项 | 受控 | 查询 license 授权容量，给容量审计或 license 运维使用。 |
| `zstack_license_authorized_nodes` | 管理员/专项 | 受控 | 查询 license 授权节点，给节点授权审计或 license 运维使用。 |
| `zstack_mn_nodes` | 管理员/专项 | 受控 | 查询管理节点，给平台运维、license 或高可用排障使用。 |
| `zstack_sdn_controllers` | 管理员/专项 | 受控 | 查询 SDN 控制器，给 SDN 网络专项能力使用。 |
| `zstack_gpu_devices` | 管理员/专项 | 受控 | 查询 GPU 设备，给 GPU 资源池、调度或硬件排障使用。 |
| `zstack_hook_scripts` | 管理员/专项 | 受控 | 查询 hook script，给平台脚本或兼容场景排查使用。 |
| `zstack_instance_guest_tools` | 管理员/专项 | 受控 | 查询 VM guest tools 状态，给脚本执行、Guest 能力或排障使用。 |

## 查询方式选择

多数资源列表型 data source 支持这几类输入。少数管理员型或平台状态型 data source 只有专用参数或无输入参数，使用前以对应 provider 参考页为准。

| 方式 | 适用场景 | 建议 |
|---|---|---|
| `uuid` | 自动化脚本、CI/CD、资源 UUID 已知 | 最稳定，通常返回 0 或 1 条；与 `name` / `name_pattern` 互斥 |
| `name` | 人工编写、名称唯一 | 适合客户示例；如果名称可能重复，必须输出结果并确认 |
| `name_pattern` | 模糊查找、探索环境 | 类似 SQL `LIKE`，`%` 匹配多个字符，`_` 匹配单个字符；只用于发现 |
| `filter` | 按状态、类型、架构、所属资源等字段筛选 | 适合在 name/name_pattern/全量结果上继续缩小候选集 |

常见执行顺序是：先用 `uuid`、`name` 或 `name_pattern` 让 ZStack API 缩小范围，再由 provider 在返回结果上应用 `filter`。如果既没有唯一名称，也没有 UUID，先做发现查询，输出候选列表，不要直接把第一条结果用于创建资源。

## Data Source 结构

典型 data source 由三部分组成：

1. **选择条件**：`uuid`、`name`、`name_pattern` 或专用参数，例如 `category`。
2. **过滤条件**：一个或多个 `filter` block。
3. **结果列表**：只读属性列表，例如 `images`、`l3networks`、`vminstances`。

示例：

```hcl
data "zstack_images" "ready_linux" {
  name_pattern = var.image_name_pattern

  filter {
    name   = "state"
    values = ["Enabled"]
  }

  filter {
    name   = "status"
    values = ["Ready"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64", "aarch64"]
  }
}

output "candidate_images" {
  description = "Image candidates after name pattern and filters."
  value       = data.zstack_images.ready_linux.images
}
```

这个例子表示：镜像名称先按 `name_pattern` 做模糊匹配，再保留 `state` 为 `Enabled`、`status` 为 `Ready`、并且架构为 `x86_64` 或 `aarch64` 的镜像。

## Filter 规则

`filter` 的结构是：

```hcl
filter {
  name   = "field_name"
  values = ["value1", "value2"]
}
```

规则：

- `name` 填 data source 返回项里的字段名，例如 `state`、`status`、`architecture`、`category`、`zone_uuid`。
- `values` 是字符串集合；数字和布尔值也建议写成字符串，例如 `values = ["1"]`、`values = ["true"]`。
- 同一个 `filter` block 内多个 `values` 是 OR：字段值等于任意一个值即可。
- 多个 `filter` block 之间是 AND：每个 block 都要匹配。
- `filter` 是精确匹配，不是模糊匹配；需要模糊名称时使用 `name_pattern`。
- 优先过滤返回项的顶层标量字段。嵌套列表字段，例如 VM 的网卡列表，除非 provider 参考页或测试明确支持，否则不要直接作为 filter key。
- 字段名必须来自对应 data source 的 schema。不要凭 ZStack API 字段名猜测 Terraform 字段名。

常用 filter 示例：

```hcl
data "zstack_l3networks" "private" {
  filter {
    name   = "category"
    values = ["Private"]
  }
}

data "zstack_instances" "running_kvm" {
  filter {
    name   = "state"
    values = ["Running"]
  }

  filter {
    name   = "hypervisor_type"
    values = ["KVM"]
  }
}
```

如果 filter key 写错，provider 会返回无效字段错误；如果 values 过宽，可能返回大量候选资源。生产配置应把候选输出给人工或流水线策略确认。

## 输出与确认

发现查询的目标不是“自动选中第一条”，而是得到可审查的候选集。输出时优先包含这些字段：

- `uuid`
- `name`
- `state` / `status`
- `category` / `type`
- 所属关系，例如 `zone_uuid`、`cluster_uuid`、`host_uuid`、`l3_network_uuid`

确认候选后，再把明确的 `uuid` 或唯一 `name` 传给创建资源的示例。不要让生产资源依赖宽泛 `name_pattern` 的隐式结果顺序。

## 示例

首次验证环境时，可以只加载根目录 `.env` 中的鉴权变量，然后运行
[examples/common/02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources)。该示例故意只查询基础优先项，避免第一次运行输出过大。它默认使用
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

如果自动化脚本已经拿到 UUID，应直接使用：

```hcl
data "zstack_l3networks" "selected" {
  uuid = var.l3_network_uuid
}
```

避免在自动化配置中使用宽泛的 `name_pattern = "%Ubuntu%"`，这可能匹配多个镜像并导致不可预测的选择。

## 对应示例

见 [examples/common/02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources)。
