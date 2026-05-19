# Admin Operations

Admin operations cover Scheduler, Global Config, and License. These resources
usually affect platform behavior or license state, so production use requires
approval and rollback review.

## Scheduler

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_scheduler_job` | resource | Create a scheduled action definition, including job type and target resource UUID. |
| `zstack_scheduler_trigger` | resource | Create a scheduled trigger, defining one-time, interval, or cron execution time. |

Scheduler job defines what action is executed against which resource. Trigger
defines when it is executed.

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

Before running, confirm:

- Whether `job_type` is supported by the target ZStack environment.
- Whether the target resource UUID is correct.
- Whether the trigger is one-time, interval-based, or cron.
- Whether the action stops, deletes, or modifies production resources.

Related example:
[examples/common/17-scheduler](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/17-scheduler).

## Global Config

Common resource and data source:

| Terraform object | Type | Purpose |
|---|---|---|
| `data.zstack_global_configs` | data source | Query current value, default value, and description of platform global configs. |
| `zstack_global_config` | resource | Manage and modify a specific global config item. |

Global Config is platform-level configuration. Query first, then decide whether
to manage it:

```hcl
data "zstack_global_configs" "selected" {
  category = var.global_config_category
  name     = var.global_config_name
}
```

Set `manage_global_config = true` only after confirming `category`, `name`,
current value, default value, and impact scope.

Related example:
[examples/common/18-global-config](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config).

## License

Common resources and data sources:

| Terraform object | Type | Purpose |
|---|---|---|
| `data.zstack_license_authorized_capacity` | data source | Query authorized license capacity for routine checks and capacity confirmation. |
| `data.zstack_license_authorized_nodes` | data source | Query authorized license nodes to confirm node authorization scope. |
| `zstack_license` | resource | Upload and manage license text. |

License content is sensitive and should not be committed. Confirm management
node UUID before uploading a license.

```hcl
resource "zstack_license" "uploaded" {
  management_node_uuid = var.management_node_uuid
  license              = var.license_text
}
```

Guidance:

- Query authorized capacity and nodes for routine checks.
- Provider `1.1.3` authorized nodes data source does not support
  `name_pattern`; use schema-supported `uuid` or `filter` if you need to narrow
  the result.
- Upload license only through an approved change process.
- `license_text` must come from a secret store.

Related example:
[examples/common/19-license](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/19-license).
