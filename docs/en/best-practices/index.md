# Best Practices

## Provider And Authentication

- Prefer AccessKey authentication for automation.
- Pass secrets through CI/CD secret stores or environment variables.
- Do not commit `terraform.tfvars`, state files, plan files, or AccessKeys.
- This documentation and public examples are based on `ZStack-Robot/zstack`
  provider `1.1.3`.
- In private registry or ZStack application-market environments, use the exact
  provider source shown by the customer platform.

## Data Sources

- Prefer `uuid` for automation and agent-generated configurations.
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

## State And Import

- Use a remote backend for team collaboration.
- After import, run `terraform plan` and adjust the resource block until the
  plan is no-op or only contains accepted changes.
- Do not apply an imported resource if the plan shows an unexpected replacement.
