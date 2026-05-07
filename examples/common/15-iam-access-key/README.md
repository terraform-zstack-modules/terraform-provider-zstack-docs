# 15-iam-access-key

Creates a ZStack account, IAM2 project, IAM2 virtual ID, and AccessKey.

This is an administrator scenario. AccessKey secrets are sensitive and should be
stored in a secure secret manager immediately after creation.
Provider 1.1.3 requires `user_uuid` when creating an AccessKey; this example
uses the created account UUID as the AccessKey owner.
