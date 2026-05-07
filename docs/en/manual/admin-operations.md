# Admin Operations

Admin operation examples include scheduler, global config, and license
management. These workflows are sensitive and should be used by platform
administrators.

## Scheduler

Use `zstack_scheduler_job` and `zstack_scheduler_trigger` for scheduled actions.
Confirm supported job types and target resource UUIDs in the customer
environment.

See `examples/common/17-scheduler`.

## Global Config

Use `zstack_global_configs` to query current and default values before managing
`zstack_global_config`. Keep management disabled until the impact is understood.

See `examples/common/18-global-config`.

## License

Use license data sources to inspect authorized nodes and capacity. If uploading
a license, pass license text as a sensitive variable and never commit it.
Provider `1.1.3` does not support `name_pattern` on authorized nodes; use
schema-supported `uuid` or `filter` arguments when you need to narrow results.

See `examples/common/19-license`.
