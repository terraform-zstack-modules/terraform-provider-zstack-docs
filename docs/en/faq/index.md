# FAQ

## Which provider source should I use?

Use `ZStack-Robot/zstack` for the public Terraform Registry. In ZStack
application-market or private registry environments, use the exact source string
shown by the customer platform.

## Which provider version is this documentation based on?

This documentation and the runnable examples are based on ZStack provider
`1.1.2`.

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

Yes, but the environment must provide a private provider source or Terraform
provider mirror, and the ZStack provider version must be available internally.
