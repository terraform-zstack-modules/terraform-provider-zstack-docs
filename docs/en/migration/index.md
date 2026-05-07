# Migration Guide

Migration focuses on bringing existing ZStack resources under Terraform control.
The main workflow is:

1. Write the Terraform resource block that describes the intended final state.
2. Import the existing remote object into Terraform state.
3. Run `terraform plan`.
4. Fill in missing arguments until the plan is stable.
5. Apply only after the changes are understood and accepted.

Start with [Import Existing Resources](import-existing-resources.md).

## Provider 1.1.3 Notes

When upgrading from an older provider version to `1.1.3`, update
`required_providers.zstack.version`, run `terraform init -upgrade`, then run
`terraform validate` and `terraform plan` for each example or module.

Validated `1.1.3` behavior changes:

- `zstack_access_key` requires `user_uuid`. When creating an AccessKey for a
  newly created account, use that account UUID as the owner.
- `zstack_sns_email_endpoint` requires `platform_uuid`. The provider does not
  expose an SNS platform data source, so administrators must confirm the UUID in
  the target environment.
- `zstack_license_authorized_nodes` no longer supports `name_pattern`; use
  schema-supported `uuid` or `filter` arguments.
- Resource orchestration and orchestration templates are canceled and are no
  longer maintained as examples or manual pages.

If an upgrade plan shows unexpected replacement or readback drift, record the
field difference and do not apply to production until the change is understood.
