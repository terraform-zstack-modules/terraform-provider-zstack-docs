# FAQ

## Which provider source should I use?

Use `ZStack-Robot/zstack` for customer-facing documentation and public examples.
Provider development environments may use a development registry source or
Terraform CLI development overrides while testing local provider builds. Offline
customer environments should prefer a Terraform provider mirror that serves the
same provider source and version.

## Which provider version is this documentation based on?

This documentation and the runnable examples are based on ZStack provider
`1.1.3`.

## Why is AccessKey recommended?

AccessKey authentication is better suited for automation and permission
management. Account/password authentication is kept as a compatibility option.

## When should I use UUID, name, or name_pattern?

Use UUID for automation and CI/CD. Use exact names only when names are unique.
Use `name_pattern` for exploration and debugging, then review the matched
resources before applying.

## Can examples be used directly in production?

Examples are runnable starting points, not complete production modules. Add
remote backend, variable validation, permission boundaries, naming rules, tags,
and approval workflows before production use.

## Should new VM examples use l3_network_uuids?

No. Use `network_interfaces` for new configurations. It can express default NIC,
static IP, and multi-NIC requirements.

## How do I import existing resources?

Write the resource block, run `terraform import` or use an import block, then run
`terraform plan`. Iterate until the plan is no-op or only contains accepted
changes before applying.

## Does offline deployment work?

Yes, but the environment should provide a Terraform provider mirror for the
target `ZStack-Robot/zstack` version, and the runner must be able to fetch the
provider from that internal mirror.

## What changed in provider 1.1.3?

`zstack_access_key` requires `user_uuid`, `zstack_sns_email_endpoint` requires
`platform_uuid`, and `zstack_license_authorized_nodes` no longer supports
`name_pattern`. Resource orchestration and orchestration templates are canceled,
so their examples and manual pages are no longer maintained.
