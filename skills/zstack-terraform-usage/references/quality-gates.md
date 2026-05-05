# Quality Gates

Use these checks before delivering customer-facing ZStack Terraform examples or
documentation changes.

## Required Local Checks

Run from the repository root:

```bash
make quality
```

This executes `scripts/quality-gate.sh`, which checks repository layout,
sensitive file tracking, Terraform formatting, example directory structure,
variable descriptions, provider version consistency, deprecated patterns, and
placeholder hygiene.

Run formatting when Terraform files change:

```bash
make fmt
```

Run the MkDocs build when documentation navigation or Markdown pages change and
MkDocs dependencies are installed:

```bash
make docs
```

The `docs` target runs `python3 -m mkdocs build --strict`.

## Git Hooks

Install the repository hooks once per clone:

```bash
make hooks
```

The pre-commit hook runs the same quality gate as CI.

## CI/CD

The GitHub Actions workflow at `.github/workflows/docs-quality.yml` installs
Terraform and MkDocs, then runs:

```bash
make quality
make docs
```

Do not add CI steps that require real ZStack credentials to the default pull
request workflow. Environment-backed validation belongs in a separate protected
workflow or manual validation run.
