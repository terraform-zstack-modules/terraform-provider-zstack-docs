# Provider 初始化与离线 Mirror

本页说明如何初始化 ZStack provider，以及离线环境如何保持公开示例的 provider source 不变。

## 标准配置

客户文档和公开示例默认使用公开 Terraform Registry source：

```hcl
terraform {
  required_version = ">= 1.5"

  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.3"
    }
  }
}
```

初始化：

```bash
terraform init
```

升级已验证的新版本时，统一修改 version 约束后再执行：

```bash
terraform init -upgrade
terraform plan
```

未完成 plan 验证前，不要把 provider 版本升级直接推到生产 apply 流程。

## 离线环境推荐方式

离线客户环境应优先使用 Terraform provider mirror 提供同一 provider source 和版本，而不是把示例中的 source 改成内部名称。

准备 mirror 的联网环境可以在 Terraform 项目目录中执行：

```bash
terraform providers mirror /opt/terraform-provider-mirror
```

离线 runner 使用 Terraform CLI 配置文件，例如 `~/.terraformrc` 或通过 `TF_CLI_CONFIG_FILE` 指定的文件：

```hcl
provider_installation {
  filesystem_mirror {
    path    = "/opt/terraform-provider-mirror"
    include = ["registry.terraform.io/ZStack-Robot/zstack"]
  }

  direct {
    exclude = ["registry.terraform.io/ZStack-Robot/zstack"]
  }
}
```

这样 Terraform 配置仍然写：

```hcl
source = "ZStack-Robot/zstack"
```

这能减少公开示例、离线交付和升级验证之间的差异。

## Provider 开发环境

如果是在开发 Terraform provider 本身，可以使用开发 Registry source 或 Terraform CLI dev override 调试本地构建，例如：

```hcl
source = "zstack.io/terraform-provider-zstack/zstack"
```

这只适用于 provider 开发或调试环境。客户交付示例不要混入开发 source。

## 初始化失败排查

| 现象 | 检查项 |
|---|---|
| provider 下载失败 | 检查 `source`、`version`、网络代理和 mirror 路径 |
| 离线环境仍访问公网 | 检查 CLI 配置文件是否被 `TF_CLI_CONFIG_FILE` 正确加载 |
| 版本不一致 | 检查 `.terraform.lock.hcl`、mirror 内容和 `required_providers` 约束 |
| 本地开发构建未生效 | 检查 dev override 路径、二进制命名和平台架构 |

更多问题见 [故障排查](../troubleshooting/index.md)。
