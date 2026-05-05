# Import Existing Resources

Use import when an existing ZStack resource should be brought under Terraform
management.

## Recommended Workflow

1. Write the Terraform resource block with the intended final configuration.
2. Import the remote object into state.
3. Run `terraform plan`.
4. Adjust configuration until the plan shows no unintended replacement.

!!! warning
    After import, keep running `terraform plan` and filling in the resource
    block until the plan is no-op or only contains changes you explicitly
    accept. Do not run `terraform apply` while the plan shows replacement or
    unknown changes, because existing resources may be recreated.

## CLI Import

```bash
terraform import zstack_instance.existing <vm-uuid>
terraform plan
```

## Import Block

Terraform 1.5 and later can use import blocks:

```hcl
import {
  to = zstack_instance.existing
  id = var.existing_vm_uuid
}
```

## Notes

- Import writes state but does not generate complete HCL.
- The first plan after import may show differences.
- If replacement is shown, inspect immutable fields before applying.
- If a resource does not support import, query it with a data source first.

See `examples/common/10-import-existing-vm`.
