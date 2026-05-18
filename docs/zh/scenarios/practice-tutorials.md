# 实践教程

本页把 `examples/common` 和 `examples/production` 组织成可执行的学习路径。每条路径都先确认已有资源，再创建依赖资源。

## 入门路径：创建一台 VM

| 步骤 | 示例 | 目标 |
|---|---|---|
| 1 | [01-provider](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider) | 验证认证和 provider 初始化 |
| 2 | [02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources) | 找到 image、L3 network、offering |
| 3 | [03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm) | 创建 VM 并输出 UUID |
| 4 | [06-security-group](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group) | 为 VM NIC 绑定安全组 |

验收标准：`terraform plan` 可解释，VM UUID 和 NIC UUID 有输出，安全组 CIDR 来自可信来源。

## 网络入口路径：VIP、EIP 和 LB

| 步骤 | 示例 | 目标 |
|---|---|---|
| 1 | [05-eip](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip) | 创建 VIP 并绑定 EIP |
| 2 | [11-load-balancer-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web) | 创建 LB、listener 和 server group |
| 3 | [12-vpc-routing](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing) | 验证 VPC 路由建模方式 |

验收标准：VIP/LB/listener/server group UUID 可追踪，端口和 CIDR 经过评审。

## 存储与镜像路径

| 步骤 | 示例 | 目标 |
|---|---|---|
| 1 | [08-volume](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume) | 创建并挂载数据盘 |
| 2 | [09-image-query-management](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/09-image-query-management) | 查询镜像并按需创建托管镜像 |
| 3 | [20-backup-cdp](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp) | 理解备份/CDP 的环境依赖 |

验收标准：disk offering、backup storage 和业务保留策略来自真实环境确认。

## 平台治理路径

| 步骤 | 示例 | 目标 |
|---|---|---|
| 1 | [14-tags](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/14-tags) | 建立标准 tag |
| 2 | [15-iam-access-key](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key) | 创建自动化身份和 AccessKey |
| 3 | [16-monitoring-notification](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification) | 配置告警和通知基础对象 |
| 4 | [18-global-config](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config) | 以受控方式查询或管理全局配置 |

验收标准：权限边界、敏感输出和管理员变更审批都已明确。

## 生产参考路径

| 目标 | 示例 |
|---|---|
| 三层 Web 应用基础设施 | [examples/production/three-tier-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/three-tier-web) |
| Kubernetes 基础设施参考 | [examples/production/k8s-reference](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/k8s-reference) |
| 存量 VM 批量纳管 | [examples/production/import-vm-fleet](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/import-vm-fleet) |
| 自动化 IAM | [examples/production/automation-iam](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/production/automation-iam) |

生产参考样例展示工程组织方式，不替代客户生产模块。正式使用前阅读 [生产化指南](../manual/production-guide.md)。
