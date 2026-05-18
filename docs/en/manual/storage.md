# Storage

Storage examples cover data volume, volume attachment, snapshots, disk offering,
and storage lookup patterns.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_disk_offerings` | data source | Query disk offerings for data volume sizing. |
| `zstack_primary_storages` | data source | Query primary storage, which stores VM root and data volumes. |
| `zstack_backup_storages` | data source | Query image/backup storage used by image, image import, and some backup/CDP workflows. |
| `zstack_volume` | resource | Create and manage a data volume that can be attached to a VM. |
| `zstack_volume_snapshot` | resource | Create and manage volume snapshots for backup or recovery points. |

## Data Volume

Use `zstack_volume` when a data disk has its own lifecycle. Attach it to a VM
after the VM is created.

See [examples/common/08-volume](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume).

## Disk Offering

Use `zstack_disk_offerings` to query an existing disk offering by name or UUID.
Avoid hard-coding environment-specific UUIDs in reusable examples.

## Backup Storage And Primary Storage

Use storage data sources to inspect existing storage resources before image,
backup, or CDP workflows. Storage availability and type are environment-specific
and should be confirmed by a customer administrator.
