# Terraform Provider ZStack Docs

This site contains customer-facing documentation and scenario examples for the
ZStack Terraform provider.

## Quick Start

Install Terraform, configure ZStack API credentials, then run one of the
repository examples:

```bash
cd examples/common/03-create-vm
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
```

Most examples use placeholders such as image names, L3 network names, and
offering names. Replace them with values from your ZStack environment before
running `terraform apply`.

## Provider

Public Terraform Registry source:

```hcl
source  = "ZStack-Robot/zstack"
version = "1.1.3"
```

Provider documentation baseline:

- <https://registry.terraform.io/providers/ZStack-Robot/zstack/1.1.3>
