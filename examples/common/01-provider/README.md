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

For private registry or ZStack application-market environments, replace the
provider source in `main.tf` with the internal source configured by your
platform.
