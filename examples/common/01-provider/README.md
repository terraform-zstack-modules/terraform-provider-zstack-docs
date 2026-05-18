# 01-provider

Minimal provider configuration for ZStack.

Use AccessKey authentication for normal automation. The provider can also read
credentials from environment variables, so `provider "zstack" {}` can stay empty
in CI if `ZSTACK_*` values are exported.

Copy `terraform.tfvars.example` to `terraform.tfvars`, fill in your ZStack
endpoint and credentials, then run:

```bash
terraform init
terraform validate
terraform plan
```

For provider development, use a development registry source or Terraform CLI
development overrides while testing a local provider build. Customer-facing
examples should keep the public source unless the task explicitly targets
provider development.
