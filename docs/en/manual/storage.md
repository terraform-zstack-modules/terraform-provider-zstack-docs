# Storage

Storage examples cover data volume, volume attachment, snapshots, disk offering,
and storage lookup patterns.

## Data Volume

Use `zstack_volume` when a data disk has its own lifecycle. Attach it to a VM
after the VM is created.

See `examples/common/08-volume`.

## Disk Offering

Use `zstack_disk_offerings` to query an existing disk offering by name or UUID.
Avoid hard-coding environment-specific UUIDs in reusable examples.

## Backup Storage And Primary Storage

Use storage data sources to inspect existing storage resources before image,
backup, or CDP workflows. Storage availability and type are environment-specific
and should be confirmed by a customer administrator.
