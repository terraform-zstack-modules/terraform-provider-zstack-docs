# HCL Style Guide

This page provides Terraform HCL conventions that keep examples and delivery
projects readable, reviewable, and reusable.

## File Layout

| File | Content |
|---|---|
| `versions.tf` | `required_version` and `required_providers` |
| `providers.tf` | `provider "zstack"` configuration |
| `variables.tf` | External inputs and validation |
| `main.tf` | Main resources and data sources |
| `outputs.tf` | UUIDs, addresses, and diagnostic values to expose |
| `terraform.tfvars.example` | Committable variable template without real secrets |

Small examples can use fewer files, but variable descriptions, sensitive flags,
and output boundaries should still be present.

## Naming

- Use `lower_snake_case` for Terraform variables, locals, and outputs.
- Use stable semantic resource names such as `web`, `app`, or
  `database_volume`.
- Use `for_each` with stable keys for batch resources instead of drifting
  numeric indexes.
- Express environment, application, owner, and cost center through tags or
  variables.

## Variables

Every variable should include a `description`. Sensitive variables must be
marked:

```hcl
variable "zstack_access_key_secret" {
  description = "ZStack AccessKey Secret."
  type        = string
  sensitive   = true
}
```

Add `validation` for CIDR, port, and boolean-control variables. Security group
ingress CIDRs should not default to uncontrolled networks.

## ZStack Conventions

- Use `network_interfaces` for new VMs. Do not recommend old
  `l3_network_uuids`.
- In `network_interfaces`, `l3_network_uuid` is required, while `default_l3` and
  `static_ip` are optional.
- Omit `static_ip` when fixed IP is not required. If it is passed through a
  variable, `default = null` lets Terraform treat it as unset.
- Prefer UUIDs for automation. Use names only when they are known to be unique.
- Use `name_pattern` only for discovery, and output matched results for review.
- Do not invent metric names, scheduler job types, route targets, IPsec
  algorithms, or external endpoint formats.

## Outputs

Outputs are for diagnostics and downstream integration. Prefer UUIDs and key
addresses:

```hcl
output "vm_uuid" {
  description = "Created VM UUID."
  value       = zstack_instance.web.uuid
}
```

AccessKey secrets, passwords, license text, tokens, private keys, and webhook
secrets must use `sensitive = true` and should not appear in ordinary CI logs.

## Formatting And Validation

Before delivery, run:

```bash
terraform fmt
terraform validate
terraform plan
```

Examples in this documentation repository must also pass the repository quality
gate.
