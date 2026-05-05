# Quality Gates Plan

This repository uses one local quality gate script as the shared contract for
local development, Git hooks, and CI.

## Gates

| Gate | Entry Point | Purpose |
|---|---|---|
| Local quality | `make quality` | Run repository layout, secrets, Terraform format, examples, variable documentation, provider baseline, and deprecated pattern checks. |
| Local format | `make fmt` | Apply Terraform formatting to `examples/` and skill Terraform snippets. |
| Local docs build | `make docs` | Run `mkdocs build --strict` when MkDocs dependencies are installed. |
| Git hook | `make hooks` | Configure `.githooks/pre-commit` to run `scripts/quality-gate.sh`. |
| CI | `.github/workflows/docs-quality.yml` | Run `make quality` and strict MkDocs build on pushes and pull requests. |

## Non-Goals

- Do not run `terraform init`, `terraform validate`, `terraform plan`, or
  `terraform apply` in the default gate. Those commands need provider downloads,
  credentials, or a real ZStack environment.
- Do not publish `internal/`, `skills/`, or root `examples/` as customer-facing
  MkDocs pages directly.

## Upgrade Checklist

1. When the provider baseline changes, update `README.md`, `mkdocs.yml` docs,
   examples, skill references, and `scripts/quality-gate.sh`.
2. Run `make fmt`.
3. Run `make quality`.
4. Run `make docs` if MkDocs dependencies are available.
5. Commit CI, hook, skill, and documentation updates together so the gate stays
   aligned with the repository contract.
