# 最佳实践

## Provider 与认证

- 优先使用 AccessKey。
- 生产环境通过 CI/CD secret store 或环境变量传递凭证。
- 不提交 `terraform.tfvars`、state、plan 文件和 AccessKey。
- 本文档和公开示例基于 `ZStack-Robot/zstack` provider `1.1.3`。
- Provider 开发环境可以使用开发 Registry source 或 Terraform CLI dev override；不要把开发 source 混入客户交付示例。
- 离线客户环境优先通过 Terraform provider mirror 提供同一 provider source 和版本。
- 升级 provider 时先统一修改 version 约束，再执行 `terraform init -upgrade` 和逐场景 `terraform plan`。

## 查询资源

- 自动化脚本或 CI/CD 配置优先使用 `uuid`。
- 人工编写示例时，可使用唯一 `name`。
- 谨慎使用 `name_pattern`，必须输出并确认匹配结果。
- 查询已有资源后再创建依赖资源，避免硬编码不明来源的 UUID。

## VM

- 新配置使用 `network_interfaces`，不要把旧的 `l3_network_uuids` 作为推荐写法。
- 批量 VM 优先 `for_each`，用 VM 名称作为稳定 key。
- 如果 VM 需要独立生命周期的数据盘，使用 `zstack_volume` 单独管理。
- 对会产生费用或资源占用的示例，明确提醒 `terraform destroy`。

## State

- 团队协作时使用 remote backend。
- import 后先 `terraform plan`，不要直接 apply。
- 在 plan 达到 no-op 或只包含明确接受的变更前，不要 apply 导入资源。
- 如果 plan 显示 replacement，先确认不可变字段和 state 差异。

## 生产场景

- 生产参考样例放在 `examples/production`，用于展示工程组织方式，不替代客户生产模块。
- VIP/EIP：输出 VIP/EIP UUID 和绑定的 VM NIC UUID，便于后续排障。
- Load Balancer：listener 端口、后端端口、server group 使用变量管理。
- VPC/路由：route table 与 route entry 分开建模，关联关系需按环境确认。
- SSH/scripts：脚本内容不要包含明文密码、token 或私钥。
- Tag：建立统一 tag 规范，例如 environment、owner、application、cost-center。
- IAM：AccessKey 创建后立即写入 secret store，Terraform output 必须 `sensitive`。
- Monitoring：metric namespace/name 必须来自真实环境，不要凭空填写。

## 管理员场景

- Scheduler：确认 job 类型、目标资源和触发时间，避免误操作生产资源。
- Global Config：先使用 data source 查询当前值和默认值，再决定是否纳管。
- License：license 文本必须作为敏感变量传入，不提交到仓库。
- Backup/CDP：先确认 backup storage 类型、容量和带宽影响，再创建 task。
- CDP task：使用明确资源 UUID，不要用模糊查询自动覆盖大量资源。

## 示例编写质量

- 只使用当前 provider 文档、示例和测试中确认存在的 resource 与字段。
- 说明示例是否可直接运行，以及运行前必须替换哪些变量。
- 如果缺少必要 UUID 或资源名称，应使用变量占位，不要编造值。
- HCL 文件组织、变量、输出和命名规范见 [HCL 编写规范](../manual/hcl-style.md)。
- 生产 apply 前按 [生产化指南](../manual/production-guide.md) 检查 state、凭证、审批和回滚。
