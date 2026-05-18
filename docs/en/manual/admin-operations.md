# Admin Operations

Admin operation examples include scheduler, global config, and license
management. These workflows are sensitive and should be used by platform
administrators.

## Scheduler

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_scheduler_job` | resource | Create the scheduled action definition with job type and target resource UUID. |
| `zstack_scheduler_trigger` | resource | Create the trigger that controls one-time, interval, or cron timing. |

Confirm supported job types and target resource UUIDs in the customer
environment.

See [examples/common/17-scheduler](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/17-scheduler).

## Global Config

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_global_configs` | data source | Query current values, default values, and descriptions for platform global configs. |
| `zstack_global_config` | resource | Manage and change a specific global config item. |

Keep management disabled until the impact is understood.

See [examples/common/18-global-config](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config).

## License

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_license_authorized_capacity` | data source | Query authorized license capacity for routine checks. |
| `zstack_license_authorized_nodes` | data source | Query authorized license nodes and their scope. |
| `zstack_license` | resource | Upload and manage license text. |

If uploading a license, pass license text as a sensitive variable and never commit it.
Provider `1.1.3` does not support `name_pattern` on authorized nodes; use
schema-supported `uuid` or `filter` arguments when you need to narrow results.

See [examples/common/19-license](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/19-license).
