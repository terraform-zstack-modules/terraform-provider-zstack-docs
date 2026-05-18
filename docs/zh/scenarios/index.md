# 场景化示例

本章节用于按真实客户场景解释 `examples/common` 中的可运行 Terraform 示例。
更大的生产形态参考见 [生产参考样例](production-examples.md)。
如果希望按学习路径逐步执行，见 [实践教程](practice-tutorials.md)。

## 常用场景

| 场景 | 示例 |
|---|---|
| Provider 认证 | [examples/common/01-provider](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider) |
| 查询已有资源 | [examples/common/02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources) |
| 创建单台 VM | [examples/common/03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm) |
| 批量创建 VM | [examples/common/04-create-10-vms](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms) |
| VIP/EIP | [examples/common/05-eip](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/05-eip) |
| VM + 安全组 | [examples/common/06-security-group](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/06-security-group) |
| VPC 基础网络 | [examples/common/07-vpc](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/07-vpc) |
| VM + 数据盘 | [examples/common/08-volume](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/08-volume) |
| 镜像查询/管理 | [examples/common/09-image-query-management](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/09-image-query-management) |
| 导入已有 VM | [examples/common/10-import-existing-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/10-import-existing-vm) |
| Web 负载均衡 | [examples/common/11-load-balancer-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web) |
| VPC 路由 | [examples/common/12-vpc-routing](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/12-vpc-routing) |
| VM 初始化脚本 | [examples/common/13-vm-init-scripts](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/13-vm-init-scripts) |
| 标签管理 | [examples/common/14-tags](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/14-tags) |
| IAM 和 AccessKey | [examples/common/15-iam-access-key](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/15-iam-access-key) |
| 监控通知 | [examples/common/16-monitoring-notification](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification) |
| Scheduler | [examples/common/17-scheduler](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/17-scheduler) |
| Global Config | [examples/common/18-global-config](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/18-global-config) |
| License | [examples/common/19-license](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/19-license) |
| Backup / CDP | [examples/common/20-backup-cdp](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/20-backup-cdp) |
| Network Observability | [examples/common/21-network-observability](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/21-network-observability) |
| Advanced Network | [examples/common/22-advanced-network](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/22-advanced-network) |

每个示例目录包含 `main.tf`、`variables.tf`、`terraform.tfvars.example` 和 `README.md`。运行前先复制变量文件并替换为目标 ZStack 环境中的真实资源名称或 UUID。
