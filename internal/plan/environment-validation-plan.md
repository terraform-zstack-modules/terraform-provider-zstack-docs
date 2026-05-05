# ZStack Terraform Provider Docs 环境验证计划

本文档用于在真实 ZStack 环境中验证 `terraform-provider-zstack-docs`
客户文档和 examples。当前文档与 examples 基准版本为：

- Terraform CLI: `>= 1.5`
- ZStack provider: `ZStack-Robot/zstack` `1.1.2`
- Examples 根目录：`examples/common`

## 验证目标

- 确认 examples 中的 HCL 能在真实环境完成 `init`、`validate`、`plan`。
- 对低风险场景执行 `apply` 和 `destroy`，确认资源生命周期正确。
- 对管理员、高风险或环境强依赖场景先执行 data source 查询和 plan 验证。
- 记录 provider `1.1.2` 下的字段差异、环境限制和需要更新的文档说明。
- 为后续截图、FAQ、troubleshooting 和客户交付材料提供真实依据。

## 环境准备

验证前需要准备一套可回收的测试环境，避免使用生产租户或生产资源。

| 项目 | 要求 |
|---|---|
| ZStack 管理节点 | Terraform runner 可访问管理节点 API |
| Provider 来源 | 公网 Registry `ZStack-Robot/zstack` 或客户内网 mirror 中的 `1.1.2` |
| 凭证 | 测试专用 AccessKey，权限覆盖验证资源 |
| 基础镜像 | 一个可启动、状态正常的 image |
| L3 网络 | 一个可分配 IP 的 L3 network |
| Instance Offering | 一个小规格 offering |
| Disk Offering | 一个小容量 disk offering |
| 公网/出口网络 | 用于 VIP/EIP/LB 的 public L3 network |
| VPC 资源 | vRouter offering、vRouter instance 或对应网络资源 |
| 管理员权限 | P2 场景需要单独确认，默认不直接 apply |
| 备份/观测/高级网络 | 需要对应 storage、collector、IPsec peer 等真实外部条件 |

## 通用执行流程

每个 example 使用独立目录和独立 state。不要复用生产 state。

```bash
cd examples/common/<example>
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with test environment values
terraform init
terraform validate
terraform plan -out=tfplan
```

低风险场景在 plan 结果符合预期后继续：

```bash
terraform apply tfplan
terraform plan
terraform destroy
```

验证完成后删除本地生成文件：

```bash
rm -rf .terraform .terraform.lock.hcl terraform.tfvars terraform.tfstate terraform.tfstate.* tfplan
```

## 记录模板

每次验证记录以下信息：

| 字段 | 内容 |
|---|---|
| Example | `examples/common/<id>` |
| 日期 | YYYY-MM-DD |
| ZStack 版本 | 待填写 |
| Provider 版本 | `1.1.2` |
| Terraform 版本 | `terraform version` 输出 |
| 验证人 | 待填写 |
| 执行级别 | `init` / `validate` / `plan` / `apply` / `destroy` |
| 结果 | Pass / Fail / Blocked |
| 失败信息 | 错误摘要和关键日志 |
| 文档影响 | 是否需要更新 docs/examples/troubleshooting/FAQ |

## 验证级别定义

| 级别 | 含义 | 适用场景 |
|---|---|---|
| L1 | `terraform init` + `terraform validate` | 所有 examples |
| L2 | `terraform plan` | 所有 examples，除非缺少外部依赖 |
| L3 | `terraform apply` + `terraform plan` no-op | P0 和低风险 P1 |
| L4 | `terraform destroy` 后确认资源清理 | 创建资源的 P0/P1 |
| L5 | 管理员确认后 apply | Global Config、License、Backup/CDP、IAM 等高风险场景 |

## 推荐验证顺序

### 第一批：P0 核心链路

| Example | 级别 | 前置条件 | 重点检查 | Apply 建议 |
|---|---|---|---|---|
| `01-provider` | L2 | AccessKey、host、port | Provider 初始化和认证 | 可 apply；无业务资源或低风险 |
| `02-query-existing-resources` | L2 | image、L3、offering、zone、cluster、host 名称 | data source 查询是否命中唯一资源 | 不需要 apply |
| `03-create-vm` | L4 | image、L3、instance offering | VM 创建、NIC、输出 UUID | 可 apply/destroy |
| `04-create-10-vms` | L4 | 同 `03`，容量足够 | `for_each` 批量创建、destroy 清理 | 测试环境可 apply；确认配额 |
| `06-security-group` | L4 | image、L3、offering | SG、rule、attachment 是否生效 | 可 apply/destroy |
| `08-volume` | L4 | image、L3、instance offering、disk offering | volume 创建和 attach | 可 apply/destroy |
| `09-image-query-management` | L2/L3 | existing image；创建镜像需 URL 和 backup storage | 默认查询；可选 image 创建 | 默认不创建；创建需管理员确认 |
| `10-import-existing-vm` | L2/L3 | 专用已有 VM，不使用生产 VM | import 后 plan 是否 no-op | plan 未稳定前禁止 apply |

### 第二批：P1 生产常见场景

| Example | 级别 | 前置条件 | 重点检查 | Apply 建议 |
|---|---|---|---|---|
| `05-eip` | L3/L4 | public L3 UUID、测试 VM NIC UUID | VIP/EIP 创建和绑定 | 可 apply/destroy；确认公网资源可回收 |
| `07-vpc` | L2/L3 | L2 UUID、vRouter UUID、CIDR 规划 | VPC 基础网络字段和依赖 | 先 plan；apply 需网络管理员确认 |
| `11-load-balancer-web` | L3/L4 | public L3、后端 VM/网络设计 | VIP、LB、listener、server group | 可在测试网络 apply |
| `12-vpc-routing` | L2/L3 | VPC、route table、目标路由 | route table/entry 关联 | 先 plan；apply 需网络管理员确认 |
| `13-vm-init-scripts` | L3/L4 | image、L3、offering、SSH public key | script 创建和执行链路 | 可 apply；避免真实密钥 |
| `14-tags` | L3/L4 | 可打 tag 的测试资源 UUID | tag 和 attachment | 可 apply/destroy |
| `15-iam-access-key` | L2/L5 | 管理员权限、测试账号命名 | account/project/virtual ID/AccessKey | 默认只 plan；apply 需管理员确认 |
| `16-monitoring-notification` | L2/L3 | metric、email/webhook endpoint | alarm/SNS/webhook schema 和绑定 | 先 plan；真实通知需确认 |

### 第三批：P2 管理员和高级场景

| Example | 级别 | 前置条件 | 重点检查 | Apply 建议 |
|---|---|---|---|---|
| `17-scheduler` | L2/L5 | 支持的 job type、目标资源 UUID | job/trigger schema | 默认只 plan |
| `18-global-config` | L2/L5 | category/name 当前值和默认值 | query-first、manage 开关 | 不建议首次 apply |
| `19-license` | L2/L5 | management node UUID、license 文本 | capacity/node 查询、敏感变量 | 默认只查询；上传需授权 |
| `20-backup-cdp` | L2/L5 | backup storage、resource UUID、容量策略 | CDP/backup 字段和依赖 | 不建议无演练 apply |
| `21-network-observability` | L2/L5 | collector server、mirror network、endpoint | flow/mirror 配置 | 需网络观测环境 |
| `22-advanced-network` | L2/L5 | VIP、peer address、auth key、route table | IPsec 和 policy route | 需对端和网络管理员确认 |
| `23-resource-stack` | L2/L5 | template 内容、参数、预配置格式 | stack/template 创建 | 先 plan；apply 需交付场景 |

## Import 验证专项

`examples/common/10-import-existing-vm` 必须使用专用测试 VM。不要对生产 VM
进行首次验证。

验证步骤：

1. 在 ZStack 中准备一台可被销毁或可重建的测试 VM。
2. 将 VM UUID 写入 `existing_vm_uuid`。
3. 补齐 image、CPU、memory、L3、static IP 等字段。
4. 执行 `terraform init`。
5. 执行 `terraform plan`，触发 import block。
6. 反复补齐 resource block，直到 plan no-op 或只包含明确接受的变更。
7. 如果 plan 显示 replacement，记录字段差异，不执行 apply。

验收标准：

- import 后 state 中存在目标 VM。
- plan 不显示非预期 replacement。
- 文档明确记录必须补齐哪些字段。

## 验收标准

第一阶段验证完成的最低标准：

- P0 examples 全部达到 L2。
- `03-create-vm`、`06-security-group`、`08-volume` 至少达到 L4。
- `10-import-existing-vm` 至少完成一次非生产 VM 的 import + no-op plan。
- P1 examples 全部达到 L2，低风险场景至少 3 个达到 L4。
- P2 examples 全部达到 L2 或明确标记 Blocked 原因。
- 所有失败项都补充 troubleshooting 或 example README 说明。

## 失败处理

失败不要直接改成“环境问题”。先记录：

- Terraform 命令和退出码。
- Provider 错误信息。
- ZStack API 或控制台可见的资源状态。
- 输入变量值是否来自真实环境。
- 是否存在 provider `1.1.2` schema 与文档不一致。

处理路径：

1. 如果是 example 错误，修正 example 并更新 tracker。
2. 如果是文档缺口，更新 manual/troubleshooting/FAQ。
3. 如果是环境缺口，记录为 Blocked，并列出需要的资源或权限。
4. 如果疑似 provider bug，最小化复现 HCL，并回到 provider 仓库提交 issue 或测试。

## 后续产物

环境验证完成后应沉淀：

- `internal/plan/environment-validation-results.md`
- 已验证 examples 清单。
- 失败和修复记录。
- 可发布截图清单和截图文件。
- FAQ/troubleshooting 增量。
- 是否可以对外声明“examples verified against ZStack provider 1.1.2”。
