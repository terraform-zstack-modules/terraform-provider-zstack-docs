# Storage

The storage chapter prioritizes VM data volumes, snapshots, and storage
lookups.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_disk_offerings` | data source | Query disk offerings for creating data volumes or confirming disk size profiles. |
| `zstack_primary_storages` | data source | Query primary storage, which carries VM root volumes and data volumes. |
| `zstack_backup_storages` | data source | Query image/backup storage, commonly used by image, image import, and some backup/CDP workflows. |
| `zstack_volume` | resource | Create and manage a data volume that can be attached to a VM independently. |
| `zstack_volume_snapshot` | resource | Create and manage data volume snapshots for backup or recovery points. |

## Data Volume Modeling

There are two common patterns:

1. Use `data_disks` inside `zstack_instance`, suitable when data disks follow the
   VM lifecycle.
2. Use `zstack_volume` independently and set `vm_instance_uuid`, suitable when
   data disks have an independent lifecycle.

This manual prioritizes the second pattern because it is more explicit and
easier to import, resize, and back up separately.

## Example

```hcl
resource "zstack_volume" "data" {
  name               = var.data_volume_name
  disk_offering_uuid = data.zstack_disk_offerings.data.disk_offers[0].uuid
  vm_instance_uuid   = zstack_instance.vm.uuid
}
```

## Related Example

See [examples/common/08-volume](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume).
