# 15-iam-access-key

Creates a ZStack account, IAM2 project, IAM2 virtual ID, and AccessKey.

This is an administrator scenario. AccessKey secrets are sensitive and should be
stored in a secure secret manager immediately after creation.
Provider 1.1.3 requires `user_uuid` when creating an AccessKey; this example
uses the created account UUID as the AccessKey owner.

## Inputs

Set account, project, virtual ID, and AccessKey naming variables in
`terraform.tfvars`. Confirm password policy and permission boundaries before
applying in a shared environment.

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

Run `terraform destroy` only after confirming the automation identity and
AccessKey are no longer in use.
