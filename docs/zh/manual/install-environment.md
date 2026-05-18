# 安装与环境准备

本页说明运行 ZStack Terraform 示例前需要准备的本地或 CI 环境。后续章节默认这些条件已经满足。

## 基础要求

| 项目 | 要求 |
|---|---|
| Terraform CLI | `1.5` 或更高版本 |
| ZStack 管理节点 | Terraform runner 能访问管理节点地址和 API 端口 |
| 凭证 | 推荐使用 AccessKey ID 和 AccessKey Secret |
| Provider | 当前文档基于 `ZStack-Robot/zstack` provider `1.1.3` |
| 基础资源 | VM 示例通常需要已有 image、L3 network、instance offering、disk offering |
| 版本控制 | 不提交 `terraform.tfvars`、state、plan、日志和凭证文件 |

## 安装检查

```bash
terraform version
terraform -help
```

如果 `terraform version` 不能执行，先安装 Terraform CLI，并确认它在 `PATH` 中。

## 网络检查

Terraform runner 需要访问 ZStack 管理节点。按环境选择合适命令检查连通性：

```bash
curl -I http://zstack.example.com:8080
```

管理节点地址、端口和访问策略由目标环境决定。不要把示例中的 `zstack.example.com` 当作真实地址。

## 凭证传递

本地调试可以使用未提交的 `terraform.tfvars`。团队自动化建议使用 CI/CD secret store 或环境变量：

```bash
export ZSTACK_HOST="zstack.example.com"
export ZSTACK_PORT="8080"
export ZSTACK_ACCESS_KEY_ID="replace-me"
export ZSTACK_ACCESS_KEY_SECRET="replace-me"
```

PowerShell 示例：

```powershell
$env:ZSTACK_HOST = "zstack.example.com"
$env:ZSTACK_PORT = "8080"
$env:ZSTACK_ACCESS_KEY_ID = "replace-me"
$env:ZSTACK_ACCESS_KEY_SECRET = "replace-me"
```

不要把真实 AccessKey、账号密码、license 文本、私钥或 token 写入 Git。

## 本地工作目录

建议每个示例或交付项目使用独立目录：

```text
terraform-project/
  main.tf
  variables.tf
  outputs.tf
  terraform.tfvars
```

`terraform.tfvars` 只放在本地或 CI secret 注入的临时环境中。团队协作时使用 remote backend，不要共享本地 state 文件。

## 下一步

1. 阅读 [Provider 初始化与离线 Mirror](provider-init-mirror.md)。
2. 阅读 [认证与 Provider 配置](authentication.md)。
3. 使用 [查询已有资源](query-existing-resources.md) 确认 image、L3 network 和 offering。
