# Backup And CDP

Backup and CDP workflows protect data but depend heavily on real storage,
capacity, and retention requirements.

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_cdp_policy` | resource | Create a CDP policy that defines recovery point frequency, retention, and full backup interval. |
| `zstack_cdp_task` | resource | Create a CDP task that applies a policy to explicit protected resource UUIDs. |
| `zstack_volume_backup` | resource | Create a volume backup with a volume UUID and compatible backup storage UUID. |
| `zstack_database_backup` | resource | Create a platform database backup for platform recovery scenarios. |
| `zstack_zbox_backup` | resource | Create a ZBox backup for environments that use ZBox. |

## Guidance

- Confirm backup storage type before creating backup resources.
- Confirm retention, bandwidth, latency, and capacity expectations.
- Use explicit resource UUIDs for CDP tasks.
- Keep destructive or high-impact workflows behind variables.

See [examples/common/20-backup-cdp](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp).
