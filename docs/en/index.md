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

- Read [Installation And Environment](manual/install-environment.md) to confirm
  Terraform CLI, network access, and credential delivery.
- Read [Provider Initialization And Offline Mirrors](manual/provider-init-mirror.md)
  to configure the public Registry, offline mirror, or provider development
  source.
- Read [Terraform Workflow](manual/terraform-workflow.md) to understand `init`,
  `plan`, `apply`, `import`, and CI/CD flow.
- Use [Authentication](manual/authentication.md) to configure AccessKey or
  account/password authentication.
- Use [Query Existing Resources](manual/query-existing-resources.md) before
  creating VMs, networks, volumes, or images.
- Use [Practice Tutorials](scenarios/practice-tutorials.md) to choose a learning
  path for VM, network entry, storage/image, platform governance, or production
  references.
- Read the [Production Guide](manual/production-guide.md) before adapting
  examples for real environments.
