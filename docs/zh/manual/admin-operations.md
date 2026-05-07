# Admin Operations

P2 管理员运维场景覆盖 Scheduler、Global Config 和 License。这些资源通常影响平台行为或许可证状态，生产环境必须经过审批和回滚评估。

## Scheduler

常用资源：

- `zstack_scheduler_job`
- `zstack_scheduler_trigger`

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

对应 example：`examples/common/17-scheduler`。

## Global Config

常用资源和 data source：

- `data.zstack_global_configs`
- `zstack_global_config`

Global Config 是平台级配置。建议先查询，再决定是否纳管：

```hcl
data "zstack_global_configs" "selected" {
  category = var.global_config_category
  name     = var.global_config_name
}
```

只有确认 `category`、`name`、当前值、默认值和影响范围后，才设置 `manage_global_config = true`。

对应 example：`examples/common/18-global-config`。

## License

常用资源和 data source：

- `data.zstack_license_authorized_capacity`
- `data.zstack_license_authorized_nodes`
- `zstack_license`

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

对应 example：`examples/common/19-license`。
