# Migration Guide

Migration focuses on bringing existing ZStack resources under Terraform control.
The main workflow is:

1. Write the Terraform resource block that describes the intended final state.
2. Import the existing remote object into Terraform state.
3. Run `terraform plan`.
4. Fill in missing arguments until the plan is stable.
5. Apply only after the changes are understood and accepted.

Start with [Import Existing Resources](import-existing-resources.md).
