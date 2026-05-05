# Terraform Provider ZStack 客户文档资源优先级计划

## 目标

本文档用于规划 Terraform Provider ZStack 客户资料包的内容优先级。目标不是复制 provider registry reference，而是构建面向客户交付的使用手册、场景化 examples、最佳实践、故障排查、FAQ、迁移指南、截图/架构图以及可发布的网站或 PDF。

## 目标读者

- 售前：需要快速解释 Terraform + ZStack 的价值、典型场景、交付边界和架构。
- 开发者：需要可运行 examples、资源 schema 使用方式、模块化建议和 CI/CD 集成方式。
- 客户管理员：需要安装配置、认证、权限、日常变更、导入已有资源、排障和最佳实践。

## 总体原则

- 正文文档以教学表达为主，解释概念、流程、场景和取舍。
- `examples/common` 以真实可运行为主，提供完整 Terraform 项目结构。
- 资源优先级按客户价值排序，而不是按 provider 实现顺序排序。
- 第一版优先覆盖高频链路，P2/P3 先做索引和简短说明，后续按客户需求展开。
- 多语言内容分目录维护：`docs/zh`、`docs/en`，后续可扩展其他语言。
- Terraform 代码尽量从公开 Terraform Registry 文档和 GitHub provider 仓库真实 examples/tests 中提炼，避免凭空编写。

## P0：必须优先覆盖

P0 是客户第一次使用 Terraform 管理 ZStack 时一定会遇到的核心链路。第一版客户手册和核心 examples 应优先覆盖这一层。

| 类别 | 资源 / Data Source | 文档目标 |
|---|---|---|
| Provider & Auth | `provider zstack` | 安装、provider source、AccessKey、账号密码、环境变量、版本锁定 |
| 查询基础资源 | `zstack_images`, `zstack_l3networks`, `zstack_instance_offerings`, `zstack_disk_offerings`, `zstack_zone`, `zstack_clusters`, `zstack_hosts` | 教客户查询已有资源，减少硬编码和手工查 UUID |
| VM | `zstack_instance` | 单 VM、批量 VM、静态 IP、多网卡、root disk、`expunge`、`never_stop` |
| 网络基础 | `zstack_l3network`, `zstack_l2vlan_network`, `zstack_subnet_ip_range`, `zstack_reserved_ip` | 解释 ZStack 网络模型和 Terraform 表达方式 |
| 安全组 | `zstack_networking_secgroup`, `zstack_networking_secgroup_rule`, `zstack_networking_secgroup_attachment` | 最常见访问控制场景 |
| 存储基础 | `zstack_volume`, `zstack_volume_snapshot`, `zstack_disk_offering`, `zstack_primary_storage`, `zstack_backup_storage` | 数据盘、快照、存储规格、存储查询 |
| 镜像 | `zstack_image`, `zstack_virtual_router_image`, `zstack_image_store_backup_storage` | 镜像查询、上传、依赖备份存储 |
| 导入/迁移 | `terraform import` + existing resources | 从控制台已有资源迁移到 Terraform 管理 |

P0 交付目标：

- 客户手册第一版。
- 8-12 个核心 examples。
- FAQ/troubleshooting 基础版。
- 一张 Terraform + ZStack 交互架构图。
- 一张典型 VM 场景拓扑图。

## P1：客户常见生产场景

P1 适合做场景化 examples、最佳实践和生产部署说明。

| 类别 | 资源 / Data Source | 文档目标 |
|---|---|---|
| EIP/VIP | `zstack_vip`, `zstack_eip` | VM 暴露公网、VIP 分配、EIP 绑定 |
| Load Balancer | `zstack_load_balancer`, `zstack_load_balancer_listener`, `zstack_lb_server_group` | Web 服务入口、监听器、后端池 |
| VPC/路由 | `zstack_vpc`, `zstack_virtual_router_offering`, `zstack_virtual_router_instance`, `zstack_vrouter_route_table`, `zstack_vrouter_route_entry`, `zstack_vpc_firewall`, `zstack_vpc_ha_group` | VPC 网络、路由、安全边界 |
| SSH / 脚本 | `zstack_ssh_key_pair`, `zstack_instance_scripts`, `zstack_instance_scripts_execution`, `zstack_guest_tool_attachment` | VM 初始化、脚本执行、交付自动化 |
| Tag | `zstack_tag`, `zstack_tag_attachment`, `zstack_tags`, `zstack_user_tags` | 资源分类、项目标识、自动化筛选 |
| IAM | `zstack_account`, `zstack_user`, `zstack_role`, `zstack_policy`, `zstack_access_key`, `zstack_iam2_project`, `zstack_iam2_virtual_id`, `zstack_iam2_organization` | 多租户、项目、权限最小化 |
| Monitoring / Notification | `zstack_alarm`, `zstack_monitor_template`, `zstack_monitor_group`, `zstack_sns_topic`, `zstack_sns_email_endpoint`, `zstack_sns_http_endpoint`, `zstack_webhook` | 监控告警和通知集成 |

P1 交付目标：

- Web 应用场景：VM + 安全组 + EIP/VIP。
- Web 入口场景：Load Balancer + Listener + Backend。
- 私有网络场景：VPC + 路由 + 访问控制。
- 自动初始化场景：VM + SSH key + instance scripts。
- 多租户/项目场景：IAM + AccessKey。
- 监控通知场景：Alarm + SNS/Webhook。

## P2：高级运维和平台能力

P2 面向平台管理员和高级交付场景。第一版可做索引和简短说明，后续按项目需求展开。

| 类别 | 资源 / Data Source | 文档目标 |
|---|---|---|
| Scheduler | `zstack_scheduler_job`, `zstack_scheduler_trigger` | 定时任务 |
| Global Config | `zstack_global_config`, `zstack_global_configs` | 平台级参数管理，强调变更风险 |
| License | `zstack_license`, `zstack_license_authorized_nodes`, `zstack_license_authorized_capacity` | 许可证管理和容量查询 |
| CDP / Backup | `zstack_cdp_policy`, `zstack_cdp_task`, `zstack_volume_backup`, `zstack_database_backup`, `zstack_zbox_backup` | 备份、恢复、数据保护 |
| Flow / Mirror | `zstack_flow_meter`, `zstack_flow_collector`, `zstack_port_mirror`, `zstack_port_mirror_session` | 网络流量观测和排障 |
| IPSec / Policy Route | `zstack_ipsec_connection`, `zstack_policy_route_rule_set`, `zstack_policy_route_rule` | 高级网络互联 |
| Resource Stack | `zstack_resource_stack`, `zstack_stack_template`, `zstack_preconfiguration_template` | 模板化交付 |

## P3：专项/行业/硬件/集成类

P3 不阻塞第一版客户手册。先建立 reference 索引，后续根据客户场景扩展。

| 类别 | 资源 |
|---|---|
| Baremetal | `zstack_baremetal_chassis`, `zstack_baremetal_instance`, `zstack_baremetal_pxe_server` |
| External / Hybrid | `zstack_vcenter`, `zstack_aliyun_proxy_vpc`, `zstack_aliyun_proxy_vswitch`, `zstack_aliyun_nas_access_group` |
| Security Machines | `zstack_jit_security_machine`, `zstack_san_sec_security_machine`, `zstack_info_sec_security_machine`, `zstack_fi_sec_security_machine`, `zstack_flk_sec_security_machine` |
| Storage Hardware | `zstack_iscsi_server`, `zstack_nvme_server`, `zstack_ceph_pool`, `zstack_ceph_primary_storage`, `zstack_ceph_backup_storage` |
| Misc | `zstack_directory`, `zstack_dataset`, `zstack_price_table`, `zstack_email_media`, `zstack_log_server`, `zstack_snmp_agent`, `zstack_container_management_endpoint` |

## 第一阶段交付范围

第一阶段建议覆盖 P0 + 少量 P1，目标是让客户能够完成从认证、查询、创建 VM 到基础网络/存储/安全访问的闭环。

### 客户手册第一版

- Provider 安装与认证。
- Terraform 基础工作流：`init`、`validate`、`plan`、`apply`、`destroy`。
- Data Source 查询已有资源。
- 创建单台 VM。
- 批量创建 VM。
- 网络基础：L2/L3、静态 IP、子网/IP range。
- 安全组基础。
- 数据盘与快照。
- 镜像查询与镜像创建。
- 导入已有资源。

### 场景化 Examples 第一批

- `01-provider-auth`: provider 认证，AccessKey 和环境变量。
- `02-query-existing-resources`: 查询镜像、L3、规格、zone、cluster、host。
- `03-create-vm`: 创建单台 VM。
- `04-create-10-vms`: 批量创建 VM。
- `05-vm-with-volume`: VM + 数据盘。
- `06-vm-with-security-group`: VM + 安全组规则和绑定。
- `07-vm-with-vip-eip`: VM + VIP/EIP。
- `08-web-with-load-balancer`: Web 服务 + Load Balancer。
- `09-vpc-basic`: VPC 基础网络。
- `10-import-existing-vm`: 导入已有 VM。

### 最佳实践第一批

- AccessKey 优先，避免在 HCL 中写明文密码。
- 环境变量与 `terraform.tfvars` 的使用边界。
- `uuid` vs `name` vs `name_pattern`。
- 自动化/AI 生成配置优先使用 `uuid`。
- `network_interfaces` 替代旧的 `l3_network_uuids`。
- 批量资源优先使用 `for_each`，谨慎使用 `count`。
- state 管理和 remote backend 建议。
- provider 版本锁定。
- 命名规范和 tag 策略。

### Troubleshooting 第一批

- Provider 下载失败。
- 认证失败。
- data source 查不到资源。
- `name_pattern` 匹配多个资源。
- VM 创建失败。
- 静态 IP 或网络绑定失败。
- 安全组规则不生效。
- import 后 plan 想重建资源。
- apply 成功但 state 与控制台不一致。

### FAQ 第一批

- 公开 Registry provider source 和内部 provider source 如何选择？
- 为什么推荐 AccessKey？
- 什么时候用 UUID，什么时候用 name？
- examples 能不能直接用于生产？
- 如何管理多个环境？
- 如何从控制台已有资源迁移到 Terraform？
- 是否支持离线环境？

### 截图/架构图第一批

- Terraform 与 ZStack 的交互架构图。
- Terraform 执行流程图。
- Provider 认证配置示意图。
- VM + L3 + Security Group + EIP 拓扑图。
- Load Balancer 场景拓扑图。
- ZStack 控制台获取 AccessKey 的截图。
- ZStack 控制台查看资源 UUID 的截图。

## 内容来源映射

后续编写时优先从公开、客户可访问的 provider 文档和仓库提炼真实内容：

| 来源 | 用途 |
|---|---|
| `https://registry.terraform.io/providers/ZStack-Robot/zstack/1.1.2` | 当前文档基准版本的 provider 文档 |
| `https://github.com/ZStack-Robot/terraform-provider-zstack/tree/main/docs/resources` | resource reference、字段说明、导入支持 |
| `https://github.com/ZStack-Robot/terraform-provider-zstack/tree/main/docs/data-sources` | data source reference、查询字段 |
| `https://github.com/ZStack-Robot/terraform-provider-zstack/tree/main/examples/resources` | 真实 resource HCL 片段 |
| `https://github.com/ZStack-Robot/terraform-provider-zstack/tree/main/examples/data-sources` | 真实 data source HCL 片段 |
| `https://github.com/ZStack-Robot/terraform-provider-zstack/tree/main/zstack/provider` | tests、依赖关系、边界条件 |

## Agent Skill 计划

### 需求背景

HashiCorp 已提供 Terraform 通用 Agent Skills，覆盖 Terraform HCL 风格、测试、模块生成、Terraform Stacks、provider 开发、provider resource/data source 实现和 acceptance test patterns。

这些 skills 适合解决 Terraform 通用问题，但不包含 ZStack provider 的领域事实，例如：

- ZStack provider 的 public/internal provider source 差异。
- ZStack provider 的认证方式和环境变量。
- AccessKey 是推荐认证方式。
- `zstack_instance` 的真实字段和推荐写法。
- `network_interfaces` 替代旧的 `l3_network_uuids`。
- ZStack 资源之间的依赖关系。
- P0/P1/P2/P3 资源优先级。
- 公开 provider 仓库中已有 examples、tests、docs 的事实来源。

因此，如果客户使用 agent 来生成、排障、迁移或维护 ZStack Terraform 配置，需要补充一个 ZStack-specific skill。

### 第一阶段只做一个 Skill

第一阶段只规划 `zstack-terraform-usage` skill，不做 provider development skill。

`zstack-terraform-usage` 面向：

- 售前：生成场景化说明和演示配置。
- 开发者：生成可运行 Terraform examples。
- 客户管理员：生成日常运维配置、排障步骤、迁移步骤。
- 自动化 agent：根据客户输入生成 ZStack Terraform HCL，并避免编造不存在的资源名和字段。

暂不做 `zstack-provider-development` skill。Provider 开发方向后续可再评估，届时应与 HashiCorp `provider-resources`、`provider-test-patterns`、`run-acceptance-tests` skills 配合使用。

### 与 HashiCorp Skills 的关系

ZStack skill 不重复 Terraform 通用规范，而是叠加在 HashiCorp skills 之上。

推荐组合：

| 使用场景 | 建议 Skills |
|---|---|
| 生成 ZStack Terraform 配置 | HashiCorp `terraform-style-guide` + ZStack `zstack-terraform-usage` |
| 编写 Terraform test | HashiCorp `terraform-test` + ZStack `zstack-terraform-usage` |
| 迁移已有资源 | HashiCorp `terraform-search-import` + ZStack `zstack-terraform-usage` |
| 后续 provider 开发 | HashiCorp `provider-resources` + HashiCorp `provider-test-patterns` + 后续 ZStack provider development skill |

### Skill 放置位置

第一阶段将 skill 放在当前 docs repo 中，而不是单独创建 repo。

原因：

- skill 的知识来源就是客户文档、examples、troubleshooting、FAQ、migration guide。
- 文档和 skill 同仓库更容易同步维护。
- 当前仍处于信息架构和第一版内容建设阶段，单独 repo 会增加维护成本。
- 后续如果需要公开发布或独立安装，再拆分为独立 `zstack-agent-skills` 或 `zstack-terraform-skills` repo。

建议目录结构：

```text
terraform-provider-zstack-docs/
  skills/
    zstack-terraform-usage/
      SKILL.md
      references/
        provider-auth.md
        resource-priority.md
        scenario-patterns.md
        troubleshooting.md
        anti-patterns.md
      examples/
        provider-accesskey.tf
        create-vm.tf
        batch-vms.tf
        vm-with-eip.tf
        vm-with-security-group.tf
```

如果后续需要支持 Claude Code plugin 或 marketplace，可再扩展：

```text
terraform-provider-zstack-docs/
  .claude-plugin/
    plugin.json
  skills/
    zstack-terraform-usage/
      SKILL.md
```

### Skill 内容边界

`SKILL.md` 保持短，只描述触发条件、核心规则和引用文件。细节放入 `references/`，避免一次加载过多上下文。

Skill 应覆盖：

- Provider 配置：
  - public provider source。
  - internal/application-market provider source。
  - `host`、`port`。
  - AccessKey 认证。
  - account/password 认证。
  - `ZSTACK_*` 环境变量。
- 资源优先级：
  - P0/P1/P2/P3 清单。
  - 第一阶段优先场景。
- 场景生成规则：
  - provider 认证。
  - 查询已有资源。
  - 创建 VM。
  - 批量 VM。
  - VM + volume。
  - VM + security group。
  - VM + VIP/EIP。
  - Web + load balancer。
  - VPC 基础网络。
  - import 已有资源。
- ZStack-specific 最佳实践：
  - 自动化优先使用 `uuid`。
  - 人工配置可用 `name`。
  - 谨慎使用 `name_pattern`。
  - 批量资源优先使用 `for_each`。
  - 不提交 state、tfvars、AccessKey。
  - 优先从公开 provider Registry 文档和 GitHub examples/tests/docs 提取事实。
- 常见反模式：
  - 编造不存在的 resource/data source。
  - 使用过时字段。
  - 继续使用旧的 `l3_network_uuids` 作为推荐写法。
  - 混用 public/internal provider source。
  - 在 HCL 中硬编码敏感信息。
  - 生成无法运行的伪 Terraform 并声称可运行。

### 拆分独立 Repo 的条件

满足以下条件之一时，再考虑将 skill 拆分为独立 repo：

- 需要客户通过 `npx skills add ...` 或类似方式独立安装。
- 需要公开发布并独立版本化。
- skill 生命周期明显不同于客户文档。
- 需要维护多个 ZStack skills，例如 Terraform usage、provider development、ZStack API、应用市场等。
- 需要发布 Claude Code plugin marketplace 条目。

## 暂不做的事项

- 暂不深写全部 111 个 resource。
- 暂不复制 provider registry reference 到客户手册。
- 暂不为每个 resource 单独做中英文完整章节。
- 暂不重建 examples，先完成计划和内容映射。
- 暂不确定 MkDocs 或 Docusaurus 最终技术选型，网站/PDF 先保留扩展空间。
- 暂不单独创建 agent skill repo。
- 暂不做 `zstack-provider-development` skill。
