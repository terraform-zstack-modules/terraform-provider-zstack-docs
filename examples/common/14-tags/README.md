# 14-tags

Creates a tag and attaches it to one or more existing ZStack resources.

Use tags for ownership, environment, application, cost center, or automation
selection. This example uses a simple tag.

## Inputs

Edit `terraform.tfvars` with the target resource UUIDs and tag values. Use a
small, reviewed tag vocabulary before applying broadly.

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

Run `terraform destroy` only for tags that Terraform created and should remove.
