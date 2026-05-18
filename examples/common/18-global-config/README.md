# 18-global-config

Queries and manages a ZStack global config value.

Global config changes affect platform behavior. Always query the current value
first, review the default value and description, and apply only through an
approved change process.

## Inputs

Set the global config category and name in `terraform.tfvars`. Keep management
disabled until the current and default values have been reviewed.

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

If this example managed a global config value, review the plan before destroying
or changing it back to the desired platform value.
