# Backup And CDP

Backup and CDP scenarios cover data protection, recovery point management, and
platform backup. These resources affect capacity and performance, so production
use requires confirmed backup windows, retention policy, and storage type.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_cdp_policy` | resource | Create a CDP policy, defining recovery point frequency, retention time, and full backup interval. |
| `zstack_cdp_task` | resource | Create a CDP task that applies a CDP policy to specific resource UUIDs. |
| `zstack_volume_backup` | resource | Create a volume backup, requiring volume UUID and compatible backup storage UUID. |
| `zstack_database_backup` | resource | Create a platform database backup for platform-level recovery scenarios. |
| `zstack_zbox_backup` | resource | Create a ZBox backup for environments with ZBox components. |

## CDP Policy

CDP policy defines recovery points, retention time, and full backup interval:

```hcl
resource "zstack_cdp_policy" "daily" {
  name                      = var.cdp_policy_name
  recovery_point_per_second = var.recovery_point_per_second
  retention_time_per_day    = var.retention_time_per_day
}
```

## CDP Task

CDP task applies a policy to a resource list:

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

`zstack_volume_backup` requires volume UUID and backup storage UUID. Provider
documentation states that `backup_storage_uuid` must point to
ImageStoreBackupStorage; SftpBackupStorage does not support volume backup.

## Database / ZBox Backup

`zstack_database_backup` is for platform database backup.
`zstack_zbox_backup` is for ZBox scenarios and has stronger environment
dependencies.

## Guidance

- Confirm backup storage type first.
- Evaluate backup capacity and bandwidth impact.
- Test production resources with a small scope first.
- Use explicit resource UUIDs for CDP tasks. Do not use fuzzy selection to apply
  tasks to many resources automatically.

Related example:
[examples/common/20-backup-cdp](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp).
