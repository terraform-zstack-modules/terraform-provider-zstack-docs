# Best Practices

## Provider And Authentication

- Prefer AccessKey authentication for automation.
- Pass secrets through CI/CD secret stores or environment variables.
- Do not commit `terraform.tfvars`, state files, plan files, or AccessKeys.
- This documentation and public examples are based on `ZStack-Robot/zstack`
  provider `1.1.3`.
- Provider development environments may use a development registry source or
  Terraform CLI development overrides. Do not mix development provider sources
  into customer delivery examples.
- Offline customer environments should prefer a Terraform provider mirror that
  serves the same provider source and version.

## Data Sources

- Prefer `uuid` for automation and generated configurations.
- Use exact `name` only when the name is unique and controlled.
- Use `name_pattern` only for exploration, and review the matched results.
- Query existing images, networks, offerings, zones, clusters, and hosts before
  creating dependent resources.

## VM And Lifecycle

- Use `network_interfaces` for new VM examples.
- Prefer `for_each` with stable keys for multiple VMs.
- Manage independent data disks with `zstack_volume`.
- Add explicit destroy and cleanup instructions for examples that create
  billable or capacity-consuming resources.
- Use `examples/production` as reference structure for customer delivery, not
  as complete production modules.

## State And Import

- Use a remote backend for team collaboration.
- After import, run `terraform plan` and adjust the resource block until the
  plan is no-op or only contains accepted changes.
- Do not apply an imported resource if the plan shows an unexpected replacement.

## Example Quality

- Use only resources and attributes confirmed in the current provider docs,
  examples, tests, or this documentation repository.
- Explain whether an example is directly runnable and which variables must be
  replaced before running it.
- Use variables or placeholders for missing UUIDs or names. Do not invent values.
- See [HCL Style Guide](../manual/hcl-style.md) for file layout, variables,
  outputs, and naming conventions.
- Before production apply, use the [Production Guide](../manual/production-guide.md)
  to check state, credentials, approval, and rollback.
