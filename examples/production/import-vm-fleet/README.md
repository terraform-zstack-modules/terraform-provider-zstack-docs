# import-vm-fleet

Production reference workflow for importing an existing VM fleet into Terraform
state.

This example intentionally models two VMs with explicit import blocks. For a
larger fleet, copy the pattern and add one reviewed resource block per VM, or
split the fleet into smaller batches.

Workflow:

1. Confirm each VM UUID and current VM shape in ZStack.
2. Fill `terraform.tfvars` so each resource block matches the remote VM.
3. Run `terraform init`.
4. Run `terraform plan`.
5. Iterate on the resource blocks until the plan is no-op or only contains
   accepted changes.

Do not run `terraform apply` if the plan shows unexpected replacement. Import
writes state; it does not make incomplete HCL safe.
