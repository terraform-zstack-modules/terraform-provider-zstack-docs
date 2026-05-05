# Authentication And Provider Configuration

ZStack provider needs the management node endpoint and API credentials. AccessKey
authentication is recommended for automation.

## Provider Source

Public Terraform Registry:

```hcl
terraform {
  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.2"
    }
  }
}
```

In ZStack application-market or private registry environments, use the source
string shown by the platform, for example:

```hcl
source = "zstack.io/terraform-provider-zstack/zstack"
```

The private source above is only an example. Do not copy it if the customer
platform shows a different source. Do not mix public and private provider
sources in the same example set.

## AccessKey Authentication

```hcl
provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}
```

Mark the secret variable as sensitive:

```hcl
variable "zstack_access_key_secret" {
  description = "ZStack AccessKey Secret."
  type        = string
  sensitive   = true
}
```

## Environment Variables

The provider can read configuration from:

- `ZSTACK_HOST`
- `ZSTACK_PORT`
- `ZSTACK_ACCESS_KEY_ID`
- `ZSTACK_ACCESS_KEY_SECRET`
- `ZSTACK_ACCOUNT_NAME`
- `ZSTACK_ACCOUNT_PASSWORD`

Use environment variables or CI/CD secret stores for automation.

## Account And Password

Account/password authentication is supported for compatibility:

```hcl
provider "zstack" {
  host             = var.zstack_host
  port             = var.zstack_port
  account_name     = var.zstack_account_name
  account_password = var.zstack_account_password
}
```

Customer examples default to AccessKey authentication.
