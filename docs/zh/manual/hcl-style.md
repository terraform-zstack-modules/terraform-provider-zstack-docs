# HCL 编写规范

本页给出 Terraform HCL 编写规范，用于让示例和交付项目保持可读、可审查、可复用。

## 文件组织

| 文件 | 内容 |
|---|---|
| `versions.tf` | `required_version` 和 `required_providers` |
| `providers.tf` | `provider "zstack"` 配置 |
| `variables.tf` | 所有外部输入和校验 |
| `main.tf` | 主要资源和 data source |
| `outputs.tf` | 需要暴露的 UUID、地址和排障信息 |
| `terraform.tfvars.example` | 可提交的变量模板，不包含真实秘密 |

小型示例可以减少文件数量，但变量说明、敏感标记和输出边界不能省略。

## 命名

- Terraform 变量、local、output 使用 `lower_snake_case`。
- 资源名使用稳定语义，例如 `web`, `app`, `database_volume`。
- 批量资源使用 `for_each` 和稳定 key，不用易漂移的数字下标。
- 环境、业务、owner、cost center 等信息优先通过 tag 或变量表达。

## 变量

每个变量都应有 `description`。敏感变量必须标记：

```hcl
variable "zstack_access_key_secret" {
  description = "ZStack AccessKey Secret."
  type        = string
  sensitive   = true
}
```

对 CIDR、端口、开关类变量增加 `validation`。安全组入口 CIDR 不应默认放开到不受控网段。

## ZStack 约定

- 新 VM 使用 `network_interfaces`，不要推荐旧的 `l3_network_uuids`。
- `network_interfaces` 中 `l3_network_uuid` 必填，`default_l3` 和 `static_ip` 可选。
- 不需要固定 IP 时省略 `static_ip`；如果通过变量传入，`default = null` 可以让 Terraform 视为未设置。
- 自动化优先使用 UUID；名称只在确定唯一时使用。
- `name_pattern` 只用于探索查询，并输出匹配结果供确认。
- 不要编造 metric name、scheduler job type、route target、IPsec 算法或外部端点格式。

## 输出

输出用于排障和后续集成，优先暴露 UUID 和关键地址：

```hcl
output "vm_uuid" {
  description = "Created VM UUID."
  value       = zstack_instance.web.uuid
}
```

AccessKey secret、密码、license 文本、token、私钥和 webhook secret 必须使用 `sensitive = true`，并避免进入普通 CI 日志。

## 格式化与校验

提交前运行：

```bash
terraform fmt
terraform validate
terraform plan
```

文档仓库内的示例还需要通过仓库质量检查。
