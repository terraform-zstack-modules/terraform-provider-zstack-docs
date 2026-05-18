# 工作原理

Terraform Provider ZStack 把 HCL 中声明的目标状态转换为 ZStack API 调用，并用 state 记录 Terraform 地址和 ZStack UUID 的关系。

## 执行模型

1. Terraform 读取 `.tf` 文件、变量和 provider 约束。
2. `terraform init` 下载或从 mirror 加载 ZStack provider。
3. `terraform plan` 调用 data source 和资源读取接口，生成变更预览。
4. `terraform apply` 按依赖顺序调用 ZStack API 创建、更新或删除资源。
5. Terraform 把结果写入 state。

## Data Source

Data source 用于读取已有 ZStack 对象，例如 image、L3 network、offering、zone、cluster。它们不会创建资源，但会影响 plan 结果。

如果 data source 使用 `name_pattern` 匹配过宽，后续资源可能引用错误对象。生产配置应优先使用 `uuid` 或唯一 `name`。

## Resource

Resource 由 Terraform 管理生命周期。创建后，state 中会保存对应 ZStack UUID。后续 plan 会比较：

- HCL 中声明的期望值。
- state 中保存的已知值。
- ZStack API 读取到的当前值。

如果某个字段在 provider 或 ZStack API 中不可原地更新，Terraform 可能显示 replacement。看到 replacement 时先评审原因，再决定是否 apply。

## State 与漂移

State 是 Terraform 判断资源归属的核心文件。不要手工编辑 state，除非有明确的恢复流程。

如果有人绕过 Terraform 在 ZStack 控制台修改资源，下一次 plan 可能看到 drift。处理 drift 时先判断控制台修改是否应该保留，再决定更新 HCL、回滚控制台修改或接受 Terraform 变更。

## Import

Import 只把已有资源写入 state，不会自动生成完整 HCL。导入后必须运行 `terraform plan`，并补齐 resource block，直到 plan 收敛。

## 敏感值

Terraform state 和 plan 可能包含敏感值。即使变量或 output 标记为 `sensitive`，也不能把 state、plan 或调试日志当作普通文件共享。

## 能力边界

Provider 负责调用 ZStack API，不替代变更审批、容量评估、命名规范、权限设计、网络安全评审或备份策略。生产落地需要把这些流程纳入 Terraform 项目之外的交付规范。
