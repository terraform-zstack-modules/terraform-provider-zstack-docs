# Terraform Style Rules For ZStack Agents

Use this reference when generating, reviewing, or rewriting Terraform HCL for
the ZStack provider.

## File Layout

Prefer this layout for customer delivery projects:

```text
versions.tf
providers.tf
variables.tf
main.tf
outputs.tf
terraform.tfvars.example
```

Small teaching examples may keep provider, data sources, and resources in
`main.tf`, but they must still include variable descriptions, sensitive flags,
and clear outputs.

## Provider

- Customer-facing examples use `ZStack-Robot/zstack` and the repository baseline
  version unless the task is explicitly an upgrade.
- Provider development examples may use a development registry source or
  Terraform CLI dev override.
- Do not mix public and development provider sources in one example set.
- Prefer AccessKey authentication.
- Keep credentials in variables, environment variables, or secret stores.

## Naming

- Use `lower_snake_case` for variables, locals, and outputs.
- Use short semantic Terraform resource names, such as `web`, `app`,
  `data_volume`, `security_group`, and `vip`.
- For batch resources, use `for_each` with stable keys. Avoid `count` unless the
  resource identity is disposable.
- Keep customer-specific naming in variables or locals.

## Variables

- Every variable must have a `description`.
- Mark secrets and credentials with `sensitive = true`.
- Add validation for CIDRs, ports, enum-like strings, and safety toggles when the
  example accepts free-form input.
- Do not set real UUIDs, credentials, external URLs, or customer names as
  defaults.
- Prefer `default = null` for optional values that should be omitted unless the
  user sets them.

## Data Sources

- Prefer `uuid` when UUIDs are known.
- Use exact `name` only when uniqueness is guaranteed by the scenario.
- Use `name_pattern` only for discovery. Output matched candidates and require
  review before using them in managed resources.
- Do not invent data source filters or attributes.

## VM And Networking

- Use `network_interfaces` for new VM resources.
- Do not recommend old `l3_network_uuids` for new configurations.
- In each network interface, `l3_network_uuid` is required.
- `default_l3` is optional and should be set only when the example needs to mark
  the default NIC explicitly.
- `static_ip` is optional. Omit it when fixed IP is not required. If exposed as
  a variable, use `default = null`.
- Security group ingress CIDRs must come from trusted inputs. Do not default to
  broad public ingress.

## Outputs

- Output UUIDs and addresses needed for diagnostics or downstream use.
- Mark generated passwords, AccessKey secrets, license text, tokens, and private
  keys as sensitive.
- Do not print secrets in normal outputs or README examples.

## Imports

- Import examples must include a resource block before import.
- After import, instruct the user to run plan and adjust HCL until no-op or only
  accepted differences remain.
- Never suggest applying an imported resource when the plan shows unexplained
  replacement.

## Delivery Checklist

Before returning HCL or repository changes:

1. Confirm all resource and attribute names exist in trusted provider docs,
   examples, tests, or this repository.
2. Confirm required environment-specific values are variables or placeholders.
3. Run `terraform fmt` for Terraform files.
4. Run the repository quality gate when editing this repository.
5. Explain any check that could not be run.
