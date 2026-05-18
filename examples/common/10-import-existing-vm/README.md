# 10-import-existing-vm

Shows how to bring an existing VM under Terraform management.

> **Warning:** Do not run `terraform apply` immediately after import. First run
> `terraform plan` and fill in the resource arguments until the plan is no-op or
> contains only changes you intentionally accept. If the plan shows replacement,
> applying it may recreate the existing VM.

There are two import styles:

1. CLI import:

   ```bash
   terraform import zstack_instance.existing <vm-uuid>
   terraform plan
   ```

2. Terraform import block, available in Terraform 1.5 and later:

   ```hcl
   import {
     to = zstack_instance.existing
     id = var.existing_vm_uuid
   }
   ```

After import, adjust the resource block until `terraform plan` does not show an
unwanted replacement.

## Inputs

Set the existing VM UUID, expected image, L3 network, instance offering, and NIC
arguments in `terraform.tfvars`. These values should describe the current remote
VM closely enough for the plan to converge.

## Review

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform output
```

Do not run `terraform apply` until the plan is no-op or contains only reviewed,
accepted changes.
