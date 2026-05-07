# P2 执行跟踪

状态说明：

- `Not Started`: 尚未开始。
- `In Progress`: 正在执行。
- `Done`: 已完成文档或示例落地。
- `Blocked`: 被环境、schema 或外部依赖阻塞。

| # | P2 子项 | 状态 | 文档路径 | Examples 路径 | 来源 | 验证 | 备注 |
|---|---|---|---|---|---|---|---|
| 1 | Scheduler | Done | `docs/zh/manual/admin-operations.md` | `examples/common/17-scheduler` | scheduler docs/examples | `terraform fmt` | job + trigger；job type 需环境确认，未连接真实环境 apply |
| 2 | Global Config | Done | `docs/zh/manual/admin-operations.md` | `examples/common/18-global-config` | global config docs/examples | `terraform fmt` | 风险高，先 query 再 manage；未连接真实环境 apply |
| 3 | License | Done | `docs/zh/manual/admin-operations.md` | `examples/common/19-license` | license docs/examples | `terraform fmt` | license sensitive；未连接真实环境 apply |
| 4 | Backup / CDP | Done | `docs/zh/manual/backup-cdp.md` | `examples/common/20-backup-cdp` | cdp/backup docs/examples | `terraform fmt` | CDP policy/task, volume/database/zbox backup；未连接真实环境 apply |
| 5 | Network Observability | Done | `docs/zh/manual/network-observability.md` | `examples/common/21-network-observability` | flow/port mirror docs/examples | `terraform fmt` | flow meter/collector, port mirror/session；未连接真实环境 apply |
| 6 | Advanced Network | Done | `docs/zh/manual/advanced-network.md` | `examples/common/22-advanced-network` | ipsec/policy route docs/examples | `terraform fmt` | IPsec, policy route rule set/rule；未连接真实环境 apply |
| 7 | P2 docs/troubleshooting/FAQ/skill refs | Done | `docs/zh/*`, `skills/zstack-terraform-usage/*` | N/A | P2 docs/examples | 文档检查 | 补 P2 管理员场景和风险提示 |
