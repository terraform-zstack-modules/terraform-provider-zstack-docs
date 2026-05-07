# Contributing

This repository publishes customer-facing documentation and examples for the
ZStack Terraform provider. Keep changes reproducible, reviewable, and aligned
with the documented provider baseline.

## Local Quality Gate

Run the shared quality gate before opening a pull request:

```bash
make quality
```

The gate checks repository layout, tracked sensitive files, Terraform
formatting, example structure, variable descriptions, provider source/version
consistency, deprecated patterns, and placeholder hygiene.

Install the pre-commit hook once per clone:

```bash
make hooks
```

When documentation navigation or Markdown pages change, also run:

```bash
make docs
```

This target runs `python3 -m mkdocs build --strict`.
CI installs MkDocs dependencies from `requirements-docs.txt`.

## Example Contract

Every runnable example under `examples/common/<scenario>/` must include exactly
these customer-facing files:

- `README.md`
- `main.tf`
- `variables.tf`
- `terraform.tfvars.example`

Every Terraform variable must include a useful `description`. Sensitive inputs,
such as AccessKey secrets, passwords, license text, webhook URLs, or IPsec
pre-shared keys, must also set `sensitive = true`.

Do not commit real `terraform.tfvars`, state files, plan files, private keys, or
environment files.

## Provider Baseline

Public examples use:

```hcl
source  = "ZStack-Robot/zstack"
version = "1.1.3"
```

Changing the provider source or version is baseline migration work. Update the
README, MkDocs pages, examples, skill references, and quality gate together.
Run `terraform init -upgrade` and validate the scenarios that will be published
or demonstrated.

## Documentation Site

The customer-facing site is built from `docs/` with MkDocs. Internal planning
documents, root `examples/`, and `skills/` are not published directly. When a
site page needs to reference runnable examples, link to the GitHub repository
instead of assuming root-level example files are copied into the site output.
