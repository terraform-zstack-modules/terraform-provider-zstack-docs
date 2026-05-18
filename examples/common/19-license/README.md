# 19-license

Queries license capacity and optionally uploads a license.

License text is sensitive. Do not commit license content in `terraform.tfvars`.
Use a secure variable source or CI/CD secret store.
Provider 1.1.3 queries authorized nodes without `name_pattern`; use `uuid` or
provider-supported filters if you need to narrow the result.

## Inputs

Set the management node UUID and license management toggle in `terraform.tfvars`.
Pass license text through a local untracked variable file or secret store.

## Run

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

## Cleanup

Do not remove or replace a production license without an approved rollback plan.
