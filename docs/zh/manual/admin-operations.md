# 管理员运维

管理员运维场景覆盖 Scheduler、Global Config 和 License。这些资源通常影响平台行为或许可证状态，生产环境必须经过审批和回滚评估。

## Scheduler

常用资源：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_scheduler_job` | resource | 创建计划任务的动作定义，指定任务类型和目标资源 UUID。 |
| `zstack_scheduler_trigger` | resource | 创建计划任务触发器，定义一次性、周期性或 cron 触发时间。 |

Scheduler job 指定要对哪个资源执行什么类型的任务，trigger 指定什么时候执行。

```hcl
resource "zstack_scheduler_job" "target" {
  name                 = var.job_name
  type                 = var.job_type
  target_resource_uuid = var.target_resource_uuid
}

resource "zstack_scheduler_trigger" "schedule" {
  name           = var.trigger_name
  scheduler_type = "cron"
  cron           = var.cron
}
```

执行前需要确认：

- `job_type` 是否被当前 ZStack 环境支持。
- target resource UUID 是否正确。
- trigger 是一次性、周期性还是 cron。
- 执行结果是否会停止、删除或修改生产资源。

对应示例：[examples/common/17-scheduler](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/17-scheduler)。

## Global Config

常用资源和 data source：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `data.zstack_global_configs` | data source | 查询平台全局配置的当前值、默认值和说明。 |
| `zstack_global_config` | resource | 纳管并修改指定全局配置项。 |

Global Config 是平台级配置。建议先查询，再决定是否纳管：

```hcl
data "zstack_global_configs" "selected" {
  category = var.global_config_category
  name     = var.global_config_name
}
```

只有确认 `category`、`name`、当前值、默认值和影响范围后，才设置 `manage_global_config = true`。

对应示例：[examples/common/18-global-config](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config)。

## License

常用资源和 data source：

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `data.zstack_license_authorized_capacity` | data source | 查询许可证授权容量，用于日常检查和容量确认。 |
| `data.zstack_license_authorized_nodes` | data source | 查询许可证授权节点，用于确认授权节点范围。 |
| `zstack_license` | resource | 上传并管理 license 文本。 |

License 内容是敏感信息，不应提交到仓库。上传 license 前需要确认管理节点 UUID。

```hcl
resource "zstack_license" "uploaded" {
  management_node_uuid = var.management_node_uuid
  license              = var.license_text
}
```

建议：

- 查询授权容量和授权节点作为日常检查。
- Provider `1.1.3` 的授权节点 data source 不支持 `name_pattern`；
  如需缩小范围，使用 provider schema 支持的 `uuid` 或 `filter`。
- 上传 license 只在审批流程中执行。
- `license_text` 必须来自 secret store。

对应示例：[examples/common/19-license](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/19-license)。
