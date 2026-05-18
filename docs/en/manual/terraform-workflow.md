# Terraform Workflow

This page defines the standard command sequence from initialization to cleanup,
and how to control changes in a team environment.

## Recommended Directory Layout

```text
project/
  versions.tf
  providers.tf
  variables.tf
  main.tf
  outputs.tf
  terraform.tfvars
```

Small examples can keep everything in `main.tf`. Production projects should
separate provider configuration, variables, resources, and outputs.

## Basic Command Sequence

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Clean up example resources with:

```bash
terraform destroy
```

In shared environments, do not skip `plan` and go directly to `apply`. If the
plan includes replacement, deletion, or high-risk admin resources, stop for
review.

## Controlled Apply

For production, save a reviewed plan and apply that exact plan:

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

Plan files can contain sensitive values. Treat them as sensitive files and do
not commit them to Git.

## Variable Files

Local examples usually start from a template:

```bash
cp terraform.tfvars.example terraform.tfvars
```

`terraform.tfvars` should contain only target-environment values. Prefer
environment variables or secret stores for real credentials.

## Import Workflow

When bringing existing resources under Terraform management:

1. Write the minimal resource block.
2. Run `terraform import` or use an import block.
3. Run `terraform plan`.
4. Fill in HCL until the plan is no-op or only contains accepted differences.
5. Then continue with the apply workflow.

Do not treat the first replacement after import as a normal change.

## CI/CD Workflow

CI should run at least:

```bash
terraform fmt -check
terraform validate
terraform plan
```

Production apply should add approval, change windows, state access control, and
credential isolation. A normal pull request workflow should not automatically
apply to a real ZStack environment.
