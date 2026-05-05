# IAM

IAM 是 P1 管理员场景，主要用于多租户、项目隔离和自动化凭证管理。

## 常用资源

- `zstack_account`
- `zstack_access_key`
- `zstack_user`
- `zstack_role`
- `zstack_policy`
- `zstack_iam2_project`
- `zstack_iam2_virtual_id`
- `zstack_iam2_organization`

## 建议

- Terraform 自动化优先使用专用 AccessKey。
- 不同环境使用不同账号或不同 AccessKey。
- AccessKey secret 只在创建后可见，应立即写入 secret store。
- 账号、项目、角色、策略变更会影响权限边界，生产环境必须走审批。
- 不要把新创建的 AccessKey 输出到普通日志；Terraform output 应标记 `sensitive`。

## 对应 Example

见 `examples/common/15-iam-access-key`。
