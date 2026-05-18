# Repository Agent Guide

This file is for coding and documentation agents such as Codex, Claude Code,
Cursor agents, and other tools that automatically inspect repository-level
instructions.

## Scope

These instructions apply to the whole repository unless a more specific
`AGENTS.md` is added in a subdirectory.

## Repository Purpose

This repository contains:

- Customer-facing ZStack Terraform provider documentation under `docs/`.
- Runnable Terraform examples under `examples/`.
- AI-agent-facing generation rules and catalogs under `skills/zstack-terraform-usage/`.
- Internal planning notes under `internal/plan/`, which are not published to the customer-facing site.

## Read Order

1. Read this `AGENTS.md` for repository-level operating rules.
2. Read `llms.txt` for LLM-oriented repository navigation.
3. For Terraform generation, review, troubleshooting, or migration tasks, read `skills/zstack-terraform-usage/SKILL.md`.
4. Load `skills/zstack-terraform-usage/references/scenario-catalog.yaml` for task workflows.
5. Load `skills/zstack-terraform-usage/references/resource-catalog.yaml` for resource/data source groups, examples, docs, and warnings.
6. Load `skills/zstack-terraform-usage/references/terraform-style.md` when generating or reviewing HCL.
7. Use `examples/common/*` and `examples/production/*` as runnable source-of-truth examples.
8. Use `docs/en/*` and `docs/zh/*` for human-facing explanations and risk notes.

## Source Of Truth

- Provider baseline: `ZStack-Robot/zstack` version `1.1.3`.
- Public provider docs: `https://registry.terraform.io/providers/ZStack-Robot/zstack/1.1.3`.
- Public provider repository: `https://github.com/ZStack-Robot/terraform-provider-zstack`.
- Terraform examples in this repository should remain consistent with the provider baseline unless an explicit upgrade task changes it.
- Provider development tasks may use a development registry source or Terraform CLI development overrides while testing a local provider build. Do not mix development provider sources into customer-facing examples.

## Terraform Rules

- Prefer AccessKey authentication for automation.
- Prefer UUID lookups for automation when UUIDs are known.
- Use exact names only when the target environment guarantees uniqueness.
- Use `name_pattern` only for discovery and expose matched candidates for review.
- Use `network_interfaces` for new VM examples. Do not recommend `l3_network_uuids` for new configurations.
- Prefer `for_each` with stable keys for long-lived batch resources.
- Follow `skills/zstack-terraform-usage/references/terraform-style.md` for file layout, naming, variables, outputs, optional values, and import guidance.
- Do not invent resource names, data source names, attributes, enum values, metric names, scheduler job types, endpoint formats, route targets, or cryptographic settings.
- Use variables or placeholders when customer-specific UUIDs, names, addresses, credentials, or external-system details are unknown.
- Mark credentials, AccessKey secrets, generated passwords, license text, webhook tokens, private keys, and similar values as sensitive.

## Documentation Rules

- `docs/` is customer-facing. Do not add internal execution labels, planning backlog, agent instructions, or unverified screenshot placeholders there.
- Keep Chinese and English pages aligned when changing shared information architecture, navigation, provider baseline, or example links.
- Use GitHub links for references from published docs to root-level `examples/` paths.
- Keep root `README.md` and `README.zh-CN.md` linked to each other.
- Keep AI-facing content in `AGENTS.md`, `llms.txt`, or `skills/zstack-terraform-usage/`, not in customer-facing pages.

## Safety Rules

- Do not commit or create real credentials, AccessKeys, license text, state files, plan files, private keys, or customer environment secrets.
- Do not claim examples are production-ready unless backend, state access control, variables, permissions, naming, tagging, approvals, and rollback are addressed.
- Do not run environment-backed Terraform apply/destroy workflows unless the user explicitly asks and credentials/environment are confirmed.
- Do not revert unrelated user changes in a dirty worktree.

## Validation

Run from the repository root before delivery:

```bash
make quality
```

When Markdown pages, MkDocs navigation, or documentation structure changed, also run:

```bash
make docs
```

When Terraform examples changed, also run:

```bash
make fmt
```

If a required check cannot be run, explain the reason and the residual risk.
