---
name: zstack-terraform-usage
description: Generate, review, troubleshoot, or migrate Terraform configurations for the ZStack Terraform provider. Use when working with ZStack provider authentication, data sources, VM creation, networking, security groups, storage, images, EIP/VIP, import workflows, or customer-facing ZStack Terraform examples.
---

# ZStack Terraform Usage

Use this skill to produce customer-ready Terraform configuration and guidance for the ZStack Terraform provider.

## Core Rules

1. Follow HashiCorp Terraform style conventions for file layout, naming, variables, outputs, formatting, and secrets handling.
2. Use ZStack provider facts from public, customer-accessible sources:
   - Terraform Registry provider docs for the documentation baseline version: `https://registry.terraform.io/providers/ZStack-Robot/zstack/1.1.3`
   - Public provider repository: `https://github.com/ZStack-Robot/terraform-provider-zstack`
   - This documentation repository's `docs/`, `examples/`, and `skills/` directories.
3. Do not invent resource names, data source names, or attributes. If unsure, inspect provider docs/examples/tests first.
4. Prefer AccessKey authentication for customer automation.
5. Prefer `uuid` for automation and agent-generated data source lookups when UUIDs are known.
6. Use exact `name` for human-authored examples when names are unique.
7. Use `name_pattern` only for exploratory queries and always expose/review matching results.
8. For new VM examples, use `network_interfaces`; do not recommend old `l3_network_uuids`. In each network interface, `l3_network_uuid` is required while `default_l3` and `static_ip` are optional. Use `static_ip` only for fixed-IP requirements.
9. For batch resources, prefer `for_each` with stable keys over `count`.
10. Never hard-code real credentials, real AccessKeys, or customer secrets.
11. Before delivering repository changes, run the quality gate from `references/quality-gates.md` or explain why it could not be run.
12. For generated or reviewed HCL, apply the repository-specific style rules in `references/terraform-style.md`.

## Provider Source

Public Terraform Registry:

```hcl
source  = "ZStack-Robot/zstack"
version = "1.1.3"
```

Provider development environments may use a development registry source or
Terraform CLI development overrides while testing a local provider build, for
example:

```hcl
source = "zstack.io/terraform-provider-zstack/zstack"
```

This development source is only an example. Customer-facing documentation and
public examples should default to `ZStack-Robot/zstack`. Offline customer
environments should prefer a Terraform provider mirror that serves the same
provider source and version. Do not mix public and development provider sources
in one example set.

## References

Load only the reference needed for the task:

- `references/resource-catalog.yaml` for machine-readable resource/data source groups, examples, docs, and warnings.
- `references/scenario-catalog.yaml` for machine-readable task flows, required inputs, outputs, validations, and rejection rules.
- `references/provider-auth.md`
- `references/resource-priority.md`
- `references/scenario-patterns.md`
- `references/terraform-style.md`
- `references/troubleshooting.md`
- `references/anti-patterns.md`
- `references/quality-gates.md`

## Agent Workflow

1. Classify the user request into a scenario from `references/scenario-catalog.yaml`.
2. Load the related resource group from `references/resource-catalog.yaml`.
3. Check the matching runnable example under `examples/common` or `examples/production`.
4. Generate Terraform with explicit variables for all environment-specific values.
5. Reject or ask for missing inputs when a required UUID, endpoint, metric name, job type, route target, credential, or external-system detail cannot be inferred from trusted sources.
6. Run the quality gate before delivering repository changes, or explain why it could not be run.
