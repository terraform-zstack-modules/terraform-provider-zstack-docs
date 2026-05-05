# Provider Authentication

Recommended AccessKey provider configuration:

```hcl
provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}
```

Environment variables supported by the provider:

- `ZSTACK_HOST`
- `ZSTACK_PORT`
- `ZSTACK_ACCESS_KEY_ID`
- `ZSTACK_ACCESS_KEY_SECRET`
- `ZSTACK_ACCOUNT_NAME`
- `ZSTACK_ACCOUNT_PASSWORD`

Account/password authentication exists, but customer examples should default to AccessKey unless explicitly requested.
