# Installation And Environment

This page describes the local or CI environment required before running ZStack
Terraform examples. Later chapters assume these requirements are in place.

## Requirements

| Item | Requirement |
|---|---|
| Terraform CLI | `1.5` or later |
| ZStack management node | The Terraform runner can reach the management node host and API port |
| Credentials | AccessKey ID and AccessKey Secret are recommended |
| Provider | This documentation uses `ZStack-Robot/zstack` provider `1.1.3` |
| Base resources | VM examples usually require existing image, L3 network, instance offering, and disk offering |
| Version control | Do not commit `terraform.tfvars`, state, plan, log, or credential files |

## Installation Check

```bash
terraform version
terraform -help
```

If `terraform version` does not run, install Terraform CLI and make sure it is
available on `PATH`.

## Network Check

The Terraform runner must reach the ZStack management node. Use an environment
appropriate command to verify connectivity:

```bash
curl -I http://zstack.example.com:8080
```

The management node address, port, and access policy are environment-specific.
Do not treat `zstack.example.com` as a real endpoint.

## Credential Delivery

For local debugging, use an uncommitted `terraform.tfvars` file. For team
automation, use a CI/CD secret store or environment variables:

```bash
export ZSTACK_HOST="zstack.example.com"
export ZSTACK_PORT="8080"
export ZSTACK_ACCESS_KEY_ID="replace-me"
export ZSTACK_ACCESS_KEY_SECRET="replace-me"
```

PowerShell example:

```powershell
$env:ZSTACK_HOST = "zstack.example.com"
$env:ZSTACK_PORT = "8080"
$env:ZSTACK_ACCESS_KEY_ID = "replace-me"
$env:ZSTACK_ACCESS_KEY_SECRET = "replace-me"
```

Do not commit real AccessKeys, account passwords, license text, private keys, or
tokens to Git.

## Local Project Directory

Use a separate directory for each example or delivery project:

```text
terraform-project/
  main.tf
  variables.tf
  outputs.tf
  terraform.tfvars
```

Keep `terraform.tfvars` local or inject it through CI secrets. For team
collaboration, use a remote backend instead of sharing local state files.

## Next Steps

1. Read [Provider Initialization And Offline Mirrors](provider-init-mirror.md).
2. Read [Authentication And Provider Configuration](authentication.md).
3. Use [Query Existing Resources](query-existing-resources.md) to confirm image,
   L3 network, and offering values.
