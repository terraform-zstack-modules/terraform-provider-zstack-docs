# 20-backup-cdp

Creates CDP and backup resources:

- CDP policy
- CDP task
- volume backup
- database backup
- optional ZBox backup

Backup/CDP examples are environment-sensitive. Confirm backup storage type,
resource UUIDs, retention requirements, and capacity impact before applying.

## Inputs

Set backup storage UUID, protected resource UUIDs, CDP task type, volume UUID,
retention settings, and optional ZBox values in `terraform.tfvars`. Confirm that
the selected backup storage type supports the requested backup workflow.

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

Run `terraform destroy` only after confirming the backups, CDP task, and policy
can be removed.
