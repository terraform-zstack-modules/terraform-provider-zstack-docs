# Getting Started

Terraform Provider ZStack is used to declare ZStack cloud resources as code and
manage changes through `plan/apply`.

## Prerequisites

- Terraform 1.5 or later.
- Reachable ZStack management node.
- AccessKey ID and AccessKey Secret.
- Existing base resources: image, L3 network, instance offering, and disk
  offering.

## Recommended Learning Order

1. Configure provider and authentication.
2. Query existing resources.
3. Create a single VM.
4. Create multiple VMs.
5. Add static IP, security group, and data disk to VM.
6. Bind VIP/EIP or connect to Load Balancer.
7. Import existing resources.

## Basic Commands

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Examples

Start from [examples/common/01-provider](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider). Each example contains:

- `main.tf`
- `variables.tf`
- `terraform.tfvars.example`
- `README.md`

Copy `terraform.tfvars.example` to `terraform.tfvars`, then fill in real values.
Do not commit real `terraform.tfvars`.
