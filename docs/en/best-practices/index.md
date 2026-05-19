# Best Practices

## Provider And Authentication

- Prefer AccessKey authentication.
- Pass production credentials through CI/CD secret stores or environment
  variables.
- Do not commit `terraform.tfvars`, state files, plan files, or AccessKeys.
- This documentation and public examples are based on `ZStack-Robot/zstack`
  provider `1.1.3`.
- Provider development environments may use a development registry source or
  Terraform CLI development overrides. Do not mix development provider sources
  into customer delivery examples.
- Offline customer environments should prefer a Terraform provider mirror that
  serves the same provider source and version.
- When upgrading the provider, update version constraints consistently, then run
  `terraform init -upgrade` and scenario-level `terraform plan`.

## Data Sources

- Prefer `uuid` for automation and CI/CD configuration.
- Use exact `name` in human-authored examples only when the name is unique.
- Use `name_pattern` carefully, and always output and review matched results.
- Query existing resources before creating dependent resources; avoid
  hard-coding UUIDs from unknown sources.

## VM

- Use `network_interfaces` for new configurations. Do not recommend old
  `l3_network_uuids`.
- Prefer `for_each` for multiple VMs, using VM names as stable keys.
- Use `zstack_volume` separately when a VM needs a data disk with an independent
  lifecycle.
- For examples that consume capacity or cost, clearly remind users to run
  `terraform destroy`.

## State

- Use a remote backend for team collaboration.
- After import, run `terraform plan` before applying.
- Do not apply imported resources until the plan is no-op or only contains
  explicitly accepted changes.
- If the plan shows replacement, confirm immutable fields and state differences
  first.

## Production Scenarios

- Production reference examples live in `examples/production`; they show project
  organization and are not customer production modules.
- VIP/EIP: output VIP/EIP UUID and bound VM NIC UUID for troubleshooting.
- Load Balancer: manage listener ports, backend ports, and server groups through
  variables.
- VPC/routing: model route tables and route entries separately; confirm
  associations per environment.
- SSH/scripts: script content must not contain plaintext passwords, tokens, or
  private keys.
- Tags: establish a shared tag standard such as environment, owner,
  application, and cost-center.
- IAM: save AccessKey secrets to a secret store immediately; Terraform outputs
  must be `sensitive`.
- Monitoring: metric namespace/name must come from the real environment. Do not
  invent them.

## Admin Scenarios

- Scheduler: confirm job type, target resource, and trigger time to avoid
  unintended operations on production resources.
- Global Config: query current and default values before deciding whether to
  manage a setting.
- License: pass license text as a sensitive variable and do not commit it.
- Backup/CDP: confirm backup storage type, capacity, and bandwidth impact before
  creating tasks.
- CDP task: use explicit resource UUIDs. Do not use fuzzy queries to
  automatically cover many resources.

## Example Quality

- Use only resources and attributes confirmed in the current provider docs,
  examples, tests, or this documentation repository.
- Explain whether an example is directly runnable and which variables must be
  replaced before running it.
- Use variables or placeholders for missing UUIDs or names. Do not invent
  values.
- See [HCL Style Guide](../manual/hcl-style.md) for file layout, variables,
  outputs, and naming conventions.
- Before production apply, use the [Production Guide](../manual/production-guide.md)
  to check state, credentials, approval, and rollback.
