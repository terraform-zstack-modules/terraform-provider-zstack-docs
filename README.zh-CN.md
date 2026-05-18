# Terraform Provider ZStack 文档

[English](README.md) | [中文](README.zh-CN.md)

本仓库包含 ZStack Terraform provider 的用户文档和可运行示例。

## 目录结构

```text
terraform-provider-zstack-docs/
├── README.md
├── README.zh-CN.md
├── AGENTS.md
├── llms.txt
├── assets/
│   ├── diagrams/
│   └── screenshots/
├── docs/
│   ├── index.md
│   ├── examples/
│   ├── zh/
│   │   ├── manual/
│   │   ├── scenarios/
│   │   ├── best-practices/
│   │   ├── troubleshooting/
│   │   ├── faq/
│   │   ├── migration/
│   │   └── diagrams/
│   └── en/
│       ├── manual/
│       ├── scenarios/
│       ├── best-practices/
│       ├── troubleshooting/
│       ├── faq/
│       ├── migration/
│       └── diagrams/
├── examples/
│   ├── README.md
│   ├── common/
│       ├── 01-provider/
│       ├── 02-query-existing-resources/
│       ├── 03-create-vm/
│       ├── 04-create-10-vms/
│       ├── 05-eip/
│       ├── 06-security-group/
│       ├── 07-vpc/
│       ├── 08-volume/
│       ├── 09-image-query-management/
│       ├── 10-import-existing-vm/
│       ├── 11-load-balancer-web/
│       ├── 12-vpc-routing/
│       ├── 13-vm-init-scripts/
│       ├── 14-tags/
│       ├── 15-iam-access-key/
│       ├── 16-monitoring-notification/
│       ├── 17-scheduler/
│       ├── 18-global-config/
│       ├── 19-license/
│       ├── 20-backup-cdp/
│       ├── 21-network-observability/
│       └── 22-advanced-network/
│   └── production/
│       ├── three-tier-web/
│       ├── k8s-reference/
│       ├── import-vm-fleet/
│       └── automation-iam/
├── skills/
│   └── zstack-terraform-usage/
├── internal/
│   └── plan/
├── website/
└── mkdocs.yml
```

## 快速开始

安装 Terraform，配置 ZStack API 凭证，然后运行一个示例：

```bash
cd examples/common/03-create-vm
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
```

大多数示例使用镜像名称、L3 网络名称、规格名称等占位值。执行
`terraform apply` 前，请把这些值替换为目标 ZStack 环境中的真实值。

## AI Agent 使用方式

通用代码 agent 应先读取 [`AGENTS.md`](AGENTS.md)。LLM 工具随后读取
[`llms.txt`](llms.txt)，再加载
[`zstack-terraform-usage`](skills/zstack-terraform-usage/SKILL.md) skill。
该 skill 包含面向机器读取的资源和场景 catalog：

- [`resource-catalog.yaml`](skills/zstack-terraform-usage/references/resource-catalog.yaml)
- [`scenario-catalog.yaml`](skills/zstack-terraform-usage/references/scenario-catalog.yaml)

`docs/` 用于面向人类的解释，`examples/` 作为可运行事实来源。Agent 生成的
Terraform 应遵守 skill 规则，并在交付前运行 `make quality`。

## 本地文档站点

本仓库使用 MkDocs 组织文档：

```bash
pip install mkdocs mkdocs-material
mkdocs serve
```

打开 <http://127.0.0.1:8000> 浏览文档。

MkDocs 使用 `docs/` 作为 `docs_dir`。可运行 Terraform 示例保留在仓库根目录
的 `examples/common` 下；`docs/examples/index.md` 提供站点中的示例目录。
内部计划和验证文档位于 `internal/plan/`，不会发布到面向客户的 MkDocs 站点。

中文和英文文档都从 `docs/` 发布。英文页面与中文页面保持相同的信息架构，
并共享 `examples/common` 下的 Terraform 示例。

内部计划和验证文档包括执行跟踪、资源优先级规划以及
`internal/plan/environment-validation-plan.md`。这些文档仅供维护者使用，
不发布到面向客户的站点。

## 质量门禁

提交 pull request 前运行共享本地门禁：

```bash
make quality
```

该门禁依赖 Terraform 和 ripgrep (`rg`)。它会检查仓库结构、敏感文件跟踪、
Terraform 格式、示例结构、变量描述、provider 版本一致性、废弃模式以及占位值规范。
如需安装同一门禁作为本地 pre-commit hook：

```bash
make hooks
```

当文档导航或 Markdown 页面变更时，还应运行：

```bash
make docs
```

该目标执行 `python3 -m mkdocs build --strict`。CI 会从
`requirements-docs.txt` 安装 MkDocs 依赖。

CI 会在 pull request 和指定分支 push 时运行 `make quality` 与 `make docs`。
依赖真实 ZStack 凭证和基础设施的 Terraform 环境验证单独执行。

## Provider 版本更新

本文档和所有可运行示例基于 ZStack provider `1.1.3`，使用公网 provider source
`ZStack-Robot/zstack`。升级所有示例时，应统一更新 provider 版本，执行
`terraform init -upgrade`，然后对每个将发布或演示的场景运行 `terraform plan`。
未经验证的 provider 版本应按迁移工作处理，不要机械批量替换。
