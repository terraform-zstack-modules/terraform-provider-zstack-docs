# Import Existing Resources

Use import when existing ZStack resources need to be brought under Terraform
management.

## Recommended Workflow

1. Write the target Terraform resource block first. It should be close to the
   final desired configuration.
2. Import the existing remote object into Terraform state.
3. Run `terraform plan` to review differences between state, HCL, and the
   remote object.
4. Fill in or adjust configuration based on the plan until no unexpected
   replacement remains.

!!! warning
    After import, repeatedly run `terraform plan` and fill in the resource block
    until the plan is no-op or only contains explicitly accepted changes. Do not
    run `terraform apply` while the plan shows replacement or unknown changes,
    otherwise Terraform may recreate an existing resource.

## CLI Import

```bash
terraform import zstack_instance.existing <vm-uuid>
terraform plan
```

## Import Block

Terraform 1.5+ can use import blocks:

```hcl
import {
  to = zstack_instance.existing
  id = var.existing_vm_uuid
}
```

## Notes

- Import writes state only. It does not generate complete HCL.
- The first `plan` after import may show differences. Fill in the resource block.
- If the plan shows replacement, analyze immutable fields first and do not apply
  directly.
- Not every resource is suitable for import. If import is unsupported, query it
  as a data source first.

## Related Example

See [examples/common/10-import-existing-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/10-import-existing-vm).
