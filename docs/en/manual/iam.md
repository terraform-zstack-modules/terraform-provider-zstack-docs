# IAM

IAM is mainly used for multi-tenancy, project isolation, and automation
credential management.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_account` | resource | Create a ZStack account as the permission boundary for users, AccessKeys, or resource ownership. |
| `zstack_access_key` | resource | Create an AccessKey for Terraform or automation systems to call ZStack APIs. |
| `zstack_user` | resource | Create a user under an account for more granular login or API identity. |
| `zstack_role` | resource | Create a role that carries a set of permission policies. |
| `zstack_policy` | resource | Create a policy that defines allowed or restricted operation scope. |
| `zstack_iam2_project` | resource | Create an IAM2 project for project-level resource and permission isolation. |
| `zstack_iam2_virtual_id` | resource | Create an IAM2 virtual identity for automation or service identity inside a project. |
| `zstack_iam2_organization` | resource | Create an IAM2 organization node for organization structure and member management. |

## Guidance

- Prefer a dedicated AccessKey for Terraform automation.
- Use different accounts or AccessKeys for different environments.
- AccessKey secret is visible only after creation and should be saved to a
  secret store immediately.
- Provider `1.1.3` requires `user_uuid` when creating `zstack_access_key`; when
  creating an AccessKey for a new account, the account UUID can be used.
- Account, project, role, and policy changes affect permission boundaries and
  require production approval.
- Do not print newly created AccessKeys to ordinary logs. Terraform outputs
  should be marked `sensitive`.

## Related Example

See [examples/common/15-iam-access-key](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key).
