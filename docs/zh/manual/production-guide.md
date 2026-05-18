# 生产化指南

示例用于学习和验证 provider 行为，不等于生产模块。把 Terraform 用于真实 ZStack 环境前，至少补齐本页能力。

## 生产准入清单

| 项目 | 要求 |
|---|---|
| State | 使用 remote backend，限制读写权限，启用备份或版本保留 |
| 凭证 | 通过 secret store 或 CI/CD secret 注入，不进入 Git 和普通日志 |
| Provider | 固定版本，升级前逐场景 plan |
| 变量 | 所有环境差异通过变量表达，增加必要 validation |
| 命名和 Tag | 统一 environment、owner、application、cost-center 等标准 |
| 审批 | plan 经人工或流水线策略评审后再 apply |
| 变更窗口 | 删除、replacement、管理员资源变更必须进入变更窗口 |
| 回滚 | 明确回滚方式、数据保护和不可逆操作边界 |

## 环境隔离

不同环境建议使用独立目录、workspace 或独立 backend。关键原则是 state 边界清晰，不在同一个 state 中混放无关环境。

示例：

```text
envs/
  dev/
  test/
  prod/
modules/
  vm/
  network/
```

只有当模块边界稳定且团队已有评审流程时，才把示例抽象成复用模块。

## 变更流程

推荐流程：

1. 修改 HCL 或变量。
2. 运行格式化和校验。
3. 生成 plan。
4. 评审 replacement、删除、管理员资源和安全组规则。
5. 在批准窗口执行 apply。
6. 保存变更记录和关键 output。

生产 apply 不应由普通 pull request 自动触发。

## 高风险资源

以下资源类型需要额外评审：

- `zstack_global_config`
- License 相关资源
- IAM、account、AccessKey
- Scheduler
- Backup / CDP
- IPsec、policy route、VPC route
- 安全组入口规则和公网 VIP/EIP

如果影响范围不清楚，先在测试环境或专用资源上 plan/apply 验证。

## 存量资源纳管

导入已有资源前先确定资源归属、命名、tag 和维护窗口。导入后必须反复 plan，直到 no-op 或只剩明确接受的差异。

不要用 Terraform 接管仍由其他系统自动修改的资源，除非已经明确字段所有权。

## 安全与审计

- 输出只暴露排障必需的 UUID、地址和状态。
- 敏感 output 设置 `sensitive = true`。
- plan、state 和日志按敏感文件处理。
- 安全组和公网入口要有可信 CIDR、业务 owner 和审批记录。
- 管理员类变更保留操作者、时间、plan 摘要和回滚说明。
