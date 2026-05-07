# IAM

IAM examples are administrator scenarios. They can create accounts, projects,
virtual IDs, and AccessKeys.

Common resources:

- `zstack_account`
- `zstack_user`
- `zstack_role`
- `zstack_policy`
- `zstack_access_key`
- `zstack_iam2_project`
- `zstack_iam2_virtual_id`
- `zstack_iam2_organization`

## Guidance

- Use dedicated AccessKeys for Terraform automation.
- Use separate accounts or AccessKeys for different environments.
- Store generated AccessKey secrets immediately in a secret store.
- Provider `1.1.3` requires `user_uuid` when creating `zstack_access_key`.
  When creating an AccessKey for a newly created account, use the account UUID.
- Mark password and AccessKey outputs as `sensitive`.
- Do not print secrets in normal CI logs.

See `examples/common/15-iam-access-key`.
