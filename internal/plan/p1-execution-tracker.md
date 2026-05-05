# P1 执行跟踪

状态说明：

- `Not Started`: 尚未开始。
- `In Progress`: 正在执行。
- `Done`: 已完成文档或示例落地。
- `Blocked`: 被环境、schema 或外部依赖阻塞。

| # | P1 子项 | 状态 | 文档路径 | Examples 路径 | 来源 | 验证 | 备注 |
|---|---|---|---|---|---|---|---|
| 1 | VIP/EIP | Done | `docs/zh/manual/networking.md` | `examples/common/05-eip` | `docs/resources/vip.md`, `docs/resources/eip.md` | `terraform fmt` | P0 已有基础示例，P1 补生产说明；未连接真实环境 apply |
| 2 | Load Balancer | Done | `docs/zh/manual/load-balancer.md` | `examples/common/11-load-balancer-web` | LB docs/examples | `terraform fmt` | LB + listener + server group；未连接真实环境 apply |
| 3 | VPC/路由 | Done | `docs/zh/manual/networking.md` | `examples/common/12-vpc-routing` | VPC/route docs/examples | `terraform fmt` | VPC、route table、route entry；关联方式需环境确认 |
| 4 | SSH / Scripts | Done | `docs/zh/manual/create-vm.md` | `examples/common/13-vm-init-scripts` | ssh/script docs/examples | `terraform fmt` | SSH key、instance scripts、execution；未连接真实环境 apply |
| 5 | Tag | Done | `docs/zh/best-practices/index.md` | `examples/common/14-tags` | tag docs/examples | `terraform fmt` | tag + attachment；未连接真实环境 apply |
| 6 | IAM | Done | `docs/zh/manual/iam.md` | `examples/common/15-iam-access-key` | IAM docs/examples | `terraform fmt` | account/project/virtual id/access key；未连接真实环境 apply |
| 7 | Monitoring / Notification | Done | `docs/zh/manual/monitoring-notification.md` | `examples/common/16-monitoring-notification` | alarm/SNS/webhook docs/examples | `terraform fmt` | alarm + topic/email/webhook；metric/action 绑定需环境确认 |
| 8 | P1 docs/troubleshooting/FAQ/skill refs | Done | `docs/zh/*`, `skills/zstack-terraform-usage/*` | N/A | P1 docs/examples | 文档检查 | 补 P1 场景和反模式 |
