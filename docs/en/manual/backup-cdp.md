# Backup And CDP

Backup and CDP workflows protect data but depend heavily on real storage,
capacity, and retention requirements.

Common resources:

- `zstack_cdp_policy`
- `zstack_cdp_task`
- `zstack_volume_backup`
- `zstack_database_backup`
- `zstack_zbox_backup`

## Guidance

- Confirm backup storage type before creating backup resources.
- Confirm retention, bandwidth, latency, and capacity expectations.
- Use explicit resource UUIDs for CDP tasks.
- Keep destructive or high-impact workflows behind variables.

See `examples/common/20-backup-cdp`.
