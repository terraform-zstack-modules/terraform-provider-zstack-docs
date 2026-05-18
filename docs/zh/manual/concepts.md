# Terraform 与 ZStack 概念映射

本页解释 Terraform 术语和 ZStack 资源之间的关系，帮助读者理解后续示例为什么先查询已有资源，再创建依赖资源。

## Terraform 概念

| 概念 | 说明 |
|---|---|
| Provider | Terraform 调用 ZStack API 的插件，本手册使用 `ZStack-Robot/zstack` |
| Resource | 由 Terraform 创建、更新或删除的 ZStack 对象，例如 VM、volume、security group |
| Data source | 查询已经存在的 ZStack 对象，不直接创建资源 |
| State | Terraform 保存的实际资源映射，包含 Terraform 地址和 ZStack UUID |
| Plan | Terraform 对比 HCL、state 和远端对象后生成的变更预览 |
| Variable | 外部输入，例如管理节点地址、镜像名称、网络 UUID |
| Output | 暴露给后续流程或人工检查的值，例如 VM UUID、NIC UUID、VIP 地址 |
| Import | 把已有 ZStack 资源绑定到 Terraform state |

## ZStack 资源映射

| ZStack 对象 | Terraform 中常见用途 |
|---|---|
| Zone、Cluster、Host | 通常作为 data source 查询，用于定位已有计算资源 |
| Image | VM 创建输入；镜像管理章节可创建或查询 image |
| Backup Storage | 镜像存储/备份存储，用于 image、镜像导入和部分备份/CDP 流程 |
| Instance Offering | VM 规格；也可以改用 `cpu_num` 和 `memory_size` |
| Disk Offering | 数据盘规格 |
| L2 Network | 二层网络基础对象，通常由平台管理员预置 |
| L3 Network | VM 网卡、VIP、EIP、VPC 网络的三层网络基础 |
| VPC / Virtual Router | VPC 网络和路由能力的承载对象 |
| VIP / EIP | 对外入口地址和公网访问绑定 |
| Security Group | VM NIC 的访问控制规则集合 |
| Volume | 数据盘；需要独立生命周期时单独建模 |
| Account、User、IAM2、AccessKey | 自动化身份和权限边界 |
| Global Config、License、Scheduler | 管理员级资源，生产 apply 前需要变更评审 |

## 身份字段选择

- 自动化和 CI/CD 优先使用 `uuid`。
- 人工示例可使用唯一 `name`。
- `name_pattern` 只适合探索查询，必须输出匹配结果并人工确认。
- 不要在示例中编造 UUID、metric name、job type、route target 或外部系统地址。

## 资源依赖

Terraform 会根据表达式引用建立依赖，例如 VM 引用 image UUID、L3 network UUID 和 offering UUID。对于无法由引用表达的顺序，可以使用显式依赖，但应先确认是否真有必要。

常见顺序：

1. 查询 image、network、offering。
2. 创建 VM。
3. 创建并绑定 security group、volume、VIP/EIP 或 LB。
4. 输出 UUID 和地址用于排障或后续集成。
