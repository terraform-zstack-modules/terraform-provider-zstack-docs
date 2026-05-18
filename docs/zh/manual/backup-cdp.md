# 备份与 CDP

备份和 CDP 场景用于数据保护、恢复点管理和平台备份。此类资源对容量和性能有影响，生产使用前必须确认备份窗口、保留策略和存储类型。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_cdp_policy` | resource | 创建 CDP 策略，定义恢复点频率、保留时间和全量备份周期。 |
| `zstack_cdp_task` | resource | 创建 CDP 任务，把 CDP 策略应用到指定资源 UUID 列表。 |
| `zstack_volume_backup` | resource | 创建云盘备份，需要 volume UUID 和兼容的 backup storage UUID。 |
| `zstack_database_backup` | resource | 创建平台数据库备份，用于平台级恢复场景。 |
| `zstack_zbox_backup` | resource | 创建 ZBox 备份，适用于有 ZBox 组件的特定环境。 |

## CDP Policy

CDP policy 定义恢复点、保留时间和全量备份周期：

```hcl
resource "zstack_cdp_policy" "daily" {
  name                      = var.cdp_policy_name
  recovery_point_per_second = var.recovery_point_per_second
  retention_time_per_day    = var.retention_time_per_day
}
```

## CDP Task

CDP task 把 policy 应用到资源列表：

```hcl
resource "zstack_cdp_task" "resources" {
  name                = var.cdp_task_name
  policy_uuid         = zstack_cdp_policy.daily.uuid
  backup_storage_uuid = var.backup_storage_uuid
  resource_uuids      = var.cdp_resource_uuids
  task_type           = var.cdp_task_type
}
```

## Volume Backup

`zstack_volume_backup` 需要 volume UUID 和 backup storage UUID。Provider 文档说明 `backup_storage_uuid` 必须指向 ImageStoreBackupStorage，SftpBackupStorage 不支持 volume backup。

## Database / ZBox Backup

`zstack_database_backup` 适合平台数据库备份；`zstack_zbox_backup` 适合 ZBox 场景，环境依赖更强。

## 建议

- 先确认 backup storage 类型。
- 评估备份容量和带宽影响。
- 对 production 资源先做小范围测试。
- 对 CDP task 使用明确资源 UUID，不要用模糊选择自动套到大批资源。

对应示例：[examples/common/20-backup-cdp](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp)。
