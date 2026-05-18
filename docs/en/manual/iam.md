# IAM

IAM examples are administrator scenarios. They can create accounts, projects,
virtual IDs, and AccessKeys.

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_account` | resource | Create a ZStack account as a permission boundary and ownership scope. |
| `zstack_access_key` | resource | Create an AccessKey for Terraform or automation API access. |
| `zstack_user` | resource | Create a user under an account for login or API identity separation. |
| `zstack_role` | resource | Create a role that groups permission policies. |
| `zstack_policy` | resource | Create a permission policy that defines allowed or restricted operations. |
| `zstack_iam2_project` | resource | Create an IAM2 project for project-level resource and permission isolation. |
| `zstack_iam2_virtual_id` | resource | Create an IAM2 virtual identity for automation or service identity in a project. |
| `zstack_iam2_organization` | resource | Create an IAM2 organization node for organization and membership management. |

## Guidance

- Use dedicated AccessKeys for Terraform automation.
- Use separate accounts or AccessKeys for different environments.
- Store generated AccessKey secrets immediately in a secret store.
- Provider `1.1.3` requires `user_uuid` when creating `zstack_access_key`.
  When creating an AccessKey for a newly created account, use the account UUID.
- Mark password and AccessKey outputs as `sensitive`.
- Do not print secrets in normal CI logs.

See [examples/common/15-iam-access-key](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key).
