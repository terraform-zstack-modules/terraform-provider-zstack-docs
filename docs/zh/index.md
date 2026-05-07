# Terraform Provider ZStack 文档

本中文文档面向需要用 Terraform 管理 ZStack 环境的交付、运维和平台团队。

文档覆盖 provider 认证、已有资源查询、虚拟机创建、网络、安全组、存储、镜像、IAM、负载均衡、监控通知、备份 CDP 和高级网络等常见场景。

所有可运行示例统一放在仓库根目录的 `examples/common/` 下，站点中的示例目录会链接到 GitHub 上的对应文件。

公开示例默认使用 provider source `ZStack-Robot/zstack`，当前文档基线版本为 provider `1.1.3`。

生产环境建议优先使用 AccessKey 认证，并通过 CI/CD secret store 或环境变量传递敏感信息。

新建 VM 示例统一使用 `network_interfaces`，不再把旧的 `l3_network_uuids` 作为推荐写法。

批量资源建议使用 `for_each` 和稳定 key，避免用 `count` 导致资源地址漂移。

迁移已有资源时，应先导入 state，再反复执行 `terraform plan`，确认不会出现非预期 replacement。

管理员类资源，例如全局配置、License、IAM、备份和网络高级能力，在执行 `apply` 前必须确认权限边界和变更窗口。

Provider `1.1.3` 中，资源编排功能及编排模板不再作为当前文档和 examples 的交付范围。

如果需要排查认证、下载 provider、资源查询、VM 创建、网络绑定或 state 迁移问题，请优先查看 Troubleshooting 和 FAQ。
