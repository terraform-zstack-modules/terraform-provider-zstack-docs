# automation-iam

Production reference for Terraform automation identity management.

This example creates:

- a dedicated ZStack account
- an IAM2 project
- an IAM2 virtual ID
- an AccessKey owned by the created account

Provider 1.1.3 requires `user_uuid` when creating `zstack_access_key`; this
example uses the created account UUID as the AccessKey owner.

Generated AccessKey values are sensitive. Store them in a secret manager
immediately after creation and do not print them in normal CI logs.
