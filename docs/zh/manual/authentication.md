# 认证与 Provider 配置

ZStack provider 需要管理节点地址和 API 凭证。推荐使用 AccessKey 认证；账号密码认证只作为兼容方式使用。

## Provider Source

公网 Terraform Registry 场景：

```hcl
terraform {
  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.3"
    }
  }
}
```

Provider 开发环境如果需要调试本地构建或开发 Registry，可以按开发环境配置替换 source，例如：

```hcl
source = "zstack.io/terraform-provider-zstack/zstack"
```

上面的 source 只用于 provider 开发或调试示例。客户交付文档和公开示例默认使用
`ZStack-Robot/zstack`；离线环境应优先通过 Terraform provider mirror 提供同一
provider source 和版本，而不是在示例中随意改 source。

不要在同一个项目里混用公开发布 source 和开发调试 source。

## AccessKey 认证

推荐写法：

```hcl
provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}
```

变量示例：

```hcl
variable "zstack_access_key_secret" {
  description = "ZStack AccessKey Secret."
  type        = string
  sensitive   = true
}
```

## 环境变量

Provider 支持从环境变量读取配置：

- `ZSTACK_HOST`
- `ZSTACK_PORT`
- `ZSTACK_ACCESS_KEY_ID`
- `ZSTACK_ACCESS_KEY_SECRET`
- `ZSTACK_ACCOUNT_NAME`
- `ZSTACK_ACCOUNT_PASSWORD`

CI/CD 中优先使用环境变量或平台 secret store。不要提交真实 `terraform.tfvars`。

## 账号密码认证

账号密码认证可用于特殊场景：

```hcl
provider "zstack" {
  host             = var.zstack_host
  port             = var.zstack_port
  account_name     = var.zstack_account_name
  account_password = var.zstack_account_password
}
```

如果同时配置 AccessKey 和账号密码，容易造成认证意图不清晰。客户文档和示例默认使用 AccessKey。

## 对应示例

见 [examples/common/01-provider](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider)。
