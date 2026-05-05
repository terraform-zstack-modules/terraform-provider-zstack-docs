---
name: zstack-terraform-usage
description: Generate, review, troubleshoot, or migrate Terraform configurations for the ZStack Terraform provider. Use when working with ZStack provider authentication, data sources, VM creation, networking, security groups, storage, images, EIP/VIP, import workflows, or customer-facing ZStack Terraform examples.
---

# ZStack Terraform Usage

Use this skill to produce customer-ready Terraform configuration and guidance for the ZStack Terraform provider.

## Core Rules

1. Follow HashiCorp Terraform style conventions for file layout, naming, variables, outputs, formatting, and secrets handling.
2. Use ZStack provider facts from public, customer-accessible sources:
   - Terraform Registry provider docs for the documentation baseline version: `https://registry.terraform.io/providers/ZStack-Robot/zstack/1.1.2`
   - Public provider repository: `https://github.com/ZStack-Robot/terraform-provider-zstack`
   - This documentation repository's `docs/`, `examples/`, and `skills/` directories.
3. Do not invent resource names, data source names, or attributes. If unsure, inspect provider docs/examples/tests first.
4. Prefer AccessKey authentication for customer automation.
5. Prefer `uuid` for automation and agent-generated data source lookups when UUIDs are known.
6. Use exact `name` for human-authored examples when names are unique.
7. Use `name_pattern` only for exploratory queries and always expose/review matching results.
8. For new VM examples, use `network_interfaces`; do not recommend old `l3_network_uuids`.
9. For batch resources, prefer `for_each` with stable keys over `count`.
10. Never hard-code real credentials, real AccessKeys, or customer secrets.

## Provider Source

Public Terraform Registry:

```hcl
source  = "ZStack-Robot/zstack"
version = "1.1.2"
```

ZStack application-market or private registry environments may use an internal source, for example:

```hcl
source = "zstack.io/terraform-provider-zstack/zstack"
```

This internal source is only an example. Use the exact provider source shown by
the customer's ZStack platform, private registry, or provider mirror. Do not mix
public and internal provider sources in one example set.

## References

Load only the reference needed for the task:

- `references/provider-auth.md`
- `references/resource-priority.md`
- `references/scenario-patterns.md`
- `references/troubleshooting.md`
- `references/anti-patterns.md`
