# IAM

IAM 主要用于多租户、项目隔离和自动化凭证管理。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_account` | resource | 创建 ZStack 账号，作为用户、AccessKey 或资源归属的权限边界。 |
| `zstack_access_key` | resource | 创建 AccessKey，供 Terraform 或自动化系统调用 ZStack API。 |
| `zstack_user` | resource | 创建账号下的用户，用于细分登录或 API 身份。 |
| `zstack_role` | resource | 创建角色，承载一组权限策略。 |
| `zstack_policy` | resource | 创建权限策略，定义允许或限制的操作范围。 |
| `zstack_iam2_project` | resource | 创建 IAM2 项目，用于项目级资源和权限隔离。 |
| `zstack_iam2_virtual_id` | resource | 创建 IAM2 虚拟身份，用于项目内自动化或服务身份。 |
| `zstack_iam2_organization` | resource | 创建 IAM2 组织节点，用于组织结构和成员管理。 |

## 建议

- Terraform 自动化优先使用专用 AccessKey。
- 不同环境使用不同账号或不同 AccessKey。
- AccessKey secret 只在创建后可见，应立即写入 secret store。
- Provider `1.1.3` 创建 `zstack_access_key` 时需要 `user_uuid`；
  为新建 account 创建 AccessKey 时，可使用该 account UUID。
- 账号、项目、角色、策略变更会影响权限边界，生产环境必须走审批。
- 不要把新创建的 AccessKey 输出到普通日志；Terraform output 应标记 `sensitive`。

## 对应示例

见 [examples/common/15-iam-access-key](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key)。
