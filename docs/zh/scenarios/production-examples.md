# 生产参考样例

生产参考样例放在 `examples/production`。它们用于展示 Terraform 工程组织方式、
资源边界和交付约束，不是开箱即用的生产模块。

运行前先执行 [examples/common/02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources)，确认目标环境中的
image、L3 network、offering、disk offering、public L3 等候选资源。

| 样例 | 目录 | 说明 |
|---|---|---|
| 三层 Web 应用基础设施 | [examples/production/three-tier-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/three-tier-web) | 创建 web/app VM、数据盘、安全组、VIP/LB 和标准 tag |
| Kubernetes 基础设施参考 | [examples/production/k8s-reference](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/k8s-reference) | 创建 control-plane/worker VM、API LB 和节点安全组，不安装 Kubernetes |
| 存量 VM 批量纳管 | [examples/production/import-vm-fleet](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/import-vm-fleet) | 使用 import block 分批纳管已有 VM，强调 plan 收敛到 no-op |
| 自动化 IAM | [examples/production/automation-iam](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/automation-iam) | 创建自动化 account、IAM2 project、virtual ID 和 AccessKey |

## 使用边界

- 生产样例应接入 remote backend，并启用 state 访问控制。
- 凭证、AccessKey secret、Kubernetes token、证书和私钥必须来自 secret store。
- 样例中的 CIDR、规格、镜像和网络名称必须按目标环境确认。
- 对已有资源 import 后，必须反复执行 `terraform plan`，直到 no-op 或只包含明确接受的变更。
- 如果 plan 出现 replacement，先停止并确认不可变字段，不要直接 apply。

## 推荐验证顺序

1. `three-tier-web`：适合验证 VM、volume、security group、VIP/LB 和 tag 的组合。
2. `automation-iam`：适合验证 provider `1.1.3` 下 AccessKey `user_uuid` 行为。
3. `import-vm-fleet`：先在专用测试 VM 上演练 import。
4. `k8s-reference`：先 plan，确认节点规格和 API 入口设计，再交给 Kubernetes 安装流程。
