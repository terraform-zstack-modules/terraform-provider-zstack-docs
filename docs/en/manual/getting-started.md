# Getting Started

This guide uses ZStack provider `1.1.3` and Terraform 1.5 or later.

## Prerequisites

- Terraform CLI installed.
- Network access from the Terraform runner to the ZStack management node.
- ZStack management node host and API port.
- AccessKey ID and AccessKey Secret, or account/password credentials.
- Existing image, L3 network, and instance offering for VM examples.

## Basic Workflow

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
```

Start with `examples/common/01-provider`, then query existing resources with
`examples/common/02-query-existing-resources`. After the required resource names
or UUIDs are confirmed, move to VM and networking examples.

## Example Workflow

```bash
cd examples/common/03-create-vm
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
```

Edit `terraform.tfvars` before applying. Do not commit real `terraform.tfvars`,
state files, plan files, or credentials.
