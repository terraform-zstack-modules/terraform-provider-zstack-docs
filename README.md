# Terraform Provider ZStack Docs

[English](README.md) | [中文](README.zh-CN.md)

This repository contains user-facing documentation and examples for using the
ZStack Terraform provider.

## Directory Layout

```text
terraform-provider-zstack-docs/
├── README.md
├── README.zh-CN.md
├── AGENTS.md
├── llms.txt
├── assets/
│   ├── diagrams/
│   └── screenshots/
├── docs/
│   ├── index.md
│   ├── examples/
│   ├── zh/
│   │   ├── manual/
│   │   ├── scenarios/
│   │   ├── best-practices/
│   │   ├── troubleshooting/
│   │   ├── faq/
│   │   ├── migration/
│   │   └── diagrams/
│   └── en/
│       ├── manual/
│       ├── scenarios/
│       ├── best-practices/
│       ├── troubleshooting/
│       ├── faq/
│       ├── migration/
│       └── diagrams/
├── examples/
│   ├── README.md
│   ├── common/
│       ├── 01-provider/
│       ├── 02-query-existing-resources/
│       ├── 03-create-vm/
│       ├── 04-create-10-vms/
│       ├── 05-eip/
│       ├── 06-security-group/
│       ├── 07-vpc/
│       ├── 08-volume/
│       ├── 09-image-query-management/
│       ├── 10-import-existing-vm/
│       ├── 11-load-balancer-web/
│       ├── 12-vpc-routing/
│       ├── 13-vm-init-scripts/
│       ├── 14-tags/
│       ├── 15-iam-access-key/
│       ├── 16-monitoring-notification/
│       ├── 17-scheduler/
│       ├── 18-global-config/
│       ├── 19-license/
│       ├── 20-backup-cdp/
│       ├── 21-network-observability/
│       └── 22-advanced-network/
│   └── production/
│       ├── three-tier-web/
│       ├── k8s-reference/
│       ├── import-vm-fleet/
│       └── automation-iam/
├── skills/
│   └── zstack-terraform-usage/
├── internal/
│   └── plan/
├── website/
└── mkdocs.yml
```

## Quick Start

Install Terraform, configure ZStack API credentials, then run one of the
examples:

```bash
cd examples/common/03-create-vm
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
```

Most examples use placeholders such as image names, L3 network names, and
offering names. Replace them with values from your ZStack environment before
running `terraform apply`.

## AI Agent Usage

General coding agents should start with [`AGENTS.md`](AGENTS.md). LLM tools can
then read [`llms.txt`](llms.txt), then load the
[`zstack-terraform-usage`](skills/zstack-terraform-usage/SKILL.md) skill.
The skill includes machine-readable catalogs for choosing resources and
scenarios:

- [`resource-catalog.yaml`](skills/zstack-terraform-usage/references/resource-catalog.yaml)
- [`scenario-catalog.yaml`](skills/zstack-terraform-usage/references/scenario-catalog.yaml)

Use `docs/` for human-facing explanations and `examples/` as runnable source of
truth. Agent-generated Terraform should follow the skill rules and run
`make quality` before delivery.

## Local Documentation Site

This repository is organized for MkDocs:

```bash
pip install mkdocs mkdocs-material
mkdocs serve
```

Open <http://127.0.0.1:8000> to browse the documentation.

The MkDocs site uses `docs/` as `docs_dir`. Runnable Terraform examples stay in
the repository root under `examples/common`; `docs/examples/index.md` provides
the site catalog. Internal planning trackers live under `internal/plan/` and
are excluded from the customer-facing MkDocs site.

Chinese and English documentation are both published from `docs/`. English pages
follow the same information architecture as the Chinese pages and use the same
Terraform examples under `examples/common`.

Internal planning and validation documents include execution trackers, resource
priority planning, and `internal/plan/environment-validation-plan.md`. These are
for maintainers and are not published to the customer-facing site.

## Quality Gates

Run the shared local gate before opening a pull request:

```bash
make quality
```

The gate requires Terraform and ripgrep (`rg`). It checks repository layout,
sensitive file tracking, Terraform formatting, example structure, variable
descriptions, provider version consistency, deprecated patterns, and placeholder
hygiene. To install the same gate as a local pre-commit hook:

```bash
make hooks
```

When documentation navigation or Markdown pages change, also run:

```bash
make docs
```

This target runs `python3 -m mkdocs build --strict`.
CI installs MkDocs dependencies from `requirements-docs.txt`.

CI runs `make quality` and `make docs` on pull requests and selected branch
pushes. Environment-backed Terraform validation remains separate because it
requires ZStack credentials and real infrastructure.

## Provider Version Updates

This documentation and all runnable examples are based on ZStack provider
`1.1.3`, using the public provider source `ZStack-Robot/zstack`. When upgrading
all examples, update the provider version consistently, run
`terraform init -upgrade`, then run `terraform plan` for each scenario that will
be published or demonstrated. Treat any unverified provider version as migration
work, not a mechanical search-and-replace.
