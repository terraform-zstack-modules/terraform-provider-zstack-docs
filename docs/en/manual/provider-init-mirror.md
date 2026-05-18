# Provider Initialization And Offline Mirrors

This page explains how to initialize the ZStack provider and how offline
environments can keep the same provider source used by public examples.

## Standard Configuration

Customer-facing documentation and public examples use the public Terraform
Registry source:

```hcl
terraform {
  required_version = ">= 1.5"

  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.3"
    }
  }
}
```

Initialize the project:

```bash
terraform init
```

When upgrading to a verified new version, update the version constraint
consistently and run:

```bash
terraform init -upgrade
terraform plan
```

Do not push a provider upgrade into a production apply workflow before plan
validation is complete.

## Recommended Offline Setup

Offline customer environments should prefer a Terraform provider mirror that
serves the same provider source and version. Avoid changing example source names
to internal names.

On a connected machine, prepare the mirror from a Terraform project directory:

```bash
terraform providers mirror /opt/terraform-provider-mirror
```

On the offline runner, use a Terraform CLI configuration file such as
`~/.terraformrc`, or point `TF_CLI_CONFIG_FILE` to a dedicated file:

```hcl
provider_installation {
  filesystem_mirror {
    path    = "/opt/terraform-provider-mirror"
    include = ["registry.terraform.io/ZStack-Robot/zstack"]
  }

  direct {
    exclude = ["registry.terraform.io/ZStack-Robot/zstack"]
  }
}
```

The Terraform configuration still uses:

```hcl
source = "ZStack-Robot/zstack"
```

This keeps public examples, offline delivery, and upgrade validation aligned.

## Provider Development Environments

When developing the Terraform provider itself, a development registry source or
Terraform CLI development override can be used to test a local provider build,
for example:

```hcl
source = "zstack.io/terraform-provider-zstack/zstack"
```

Use this only for provider development or debugging. Do not mix development
sources into customer delivery examples.

## Initialization Troubleshooting

| Symptom | Check |
|---|---|
| Provider download fails | Check `source`, `version`, network proxy, and mirror path |
| Offline runner still reaches the public internet | Confirm the CLI config is loaded through `TF_CLI_CONFIG_FILE` or the default path |
| Version mismatch | Check `.terraform.lock.hcl`, mirror contents, and `required_providers` constraints |
| Local development build is not used | Check dev override path, provider binary name, and platform architecture |

See [Troubleshooting](../troubleshooting/index.md) for more diagnostics.
