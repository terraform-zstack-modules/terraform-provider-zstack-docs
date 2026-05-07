# Terraform Provider ZStack Documentation

This documentation helps presales engineers, developers, and customer
administrators use Terraform to manage ZStack resources.

The current documentation baseline is ZStack provider `1.1.3` from the public
Terraform Registry:

```hcl
source  = "ZStack-Robot/zstack"
version = "1.1.3"
```

Use the manual to understand provider configuration, common resources, import
workflows, troubleshooting, and best practices. Runnable Terraform projects are
kept under `examples/common` and are shared by all language versions.

Resource orchestration and orchestration templates are outside the current
provider `1.1.3` documentation and examples scope.

## Start Here

- Read [Getting Started](manual/getting-started.md) for the basic workflow.
- Use [Authentication](manual/authentication.md) to configure AccessKey or
  account/password authentication.
- Use [Query Existing Resources](manual/query-existing-resources.md) before
  creating VMs, networks, volumes, or images.
- Use [Scenario Examples](scenarios/index.md) to choose a runnable example.
