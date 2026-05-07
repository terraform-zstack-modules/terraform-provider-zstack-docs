# 迁移指南

本章节说明如何把已有 ZStack 资源逐步纳入 Terraform 管理。

迁移对象可能来自控制台手工创建、历史脚本/API 创建、旧 provider 版本管理，或尚未进入 Terraform state 的既有环境。

迁移的核心原则是先观察、再导入、最后收敛配置，不要直接用新 HCL 覆盖生产资源。

对已有资源执行 import 前，应先写出目标 resource block，并确认资源名称、UUID、规格、网络、镜像和生命周期字段。

import 只会把远端对象写入 Terraform state，不会自动生成完整、可维护的 HCL。

导入后必须执行 `terraform plan`，根据差异补齐配置，直到 plan 结果达到 no-op 或只包含明确接受的变更。

如果 plan 显示 replacement，先停止操作并确认不可变字段，不要直接执行 `terraform apply`。

不是所有资源都适合导入；对于不支持 import 或生命周期不清晰的资源，可以先用 data source 查询并作为依赖引用。

迁移生产资源时建议先在低风险环境演练，并保留 state 备份和回滚方案。

当前示例重点覆盖已有 VM 的导入流程，见“导入已有资源”章节和 `examples/common/10-import-existing-vm`。

## Provider 1.1.3 注意事项

从旧版本升级到 `1.1.3` 时，先统一修改 `required_providers.zstack.version`
并执行 `terraform init -upgrade`，再逐个 example 或模块执行
`terraform validate` 和 `terraform plan`。

已验证的 `1.1.3` 行为变化：

- `zstack_access_key` 创建时需要显式设置 `user_uuid`。如果为新建 account
  创建 AccessKey，可使用该 account 的 UUID 作为 owner。
- `zstack_sns_email_endpoint` 需要 `platform_uuid`。当前 provider 未提供 SNS
  platform data source，生产环境需要管理员从目标环境确认该 UUID。
- `zstack_license_authorized_nodes` 不再支持 `name_pattern` 参数；查询时使用
  provider schema 支持的 `uuid` 或 `filter`。
- 资源编排功能及编排模板已取消，不再维护对应 example 或手册页面。

升级后如果 plan 出现非预期 replacement 或 readback drift，先记录字段差异，
不要直接 apply 到生产环境。
