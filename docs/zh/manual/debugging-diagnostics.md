# 调试与诊断

本页用于排查 Terraform 与 ZStack provider 使用问题。先收集事实，再判断是配置、网络、权限、schema 还是远端资源状态问题。

## 先收集信息

排障前记录以下信息：

- Terraform CLI 版本。
- ZStack provider source 和版本。
- 执行的命令和工作目录。
- ZStack 管理节点地址和端口。
- 认证方式，隐藏真实凭证。
- 相关资源名称、UUID、状态。
- 脱敏后的 plan、错误信息和 provider 日志。

不要把 AccessKey Secret、账号密码、license 文本、私钥、token 或 state 文件原样发送给他人。

## 初始化问题

```bash
terraform init
terraform providers
```

重点检查：

- `required_providers.zstack.source` 是否为预期值。
- 离线环境是否正确加载 provider mirror 配置。
- `.terraform.lock.hcl` 中的版本是否和文档或项目约束一致。

## 认证问题

检查环境变量：

```bash
env | grep '^ZSTACK_'
```

确认 runner 能访问管理节点，并且 AccessKey 权限覆盖目标资源。不要在同一个 provider 配置里混用 AccessKey 和账号密码，除非已有明确原因。

## Data Source 问题

如果查询不到资源：

- 在 ZStack 控制台确认资源是否存在。
- 优先改用 `uuid` 精确查询。
- 如果使用 `name`，确认名称唯一。
- 如果使用 `name_pattern`，输出匹配结果并人工确认。
- 检查资源状态，例如镜像是否 `Ready` 或 `Enabled`。

## Plan 问题

`terraform plan` 是主要诊断入口。重点看：

- 是否有 replacement。
- 是否有非预期删除。
- 是否出现管理员级资源变更。
- import 后 HCL 是否还缺字段。
- 控制台变更是否造成 drift。

不清楚原因时不要 apply。

## 调试日志

需要 provider 详细日志时，可以临时开启：

```bash
TF_LOG=DEBUG TF_LOG_PATH=terraform.log terraform plan
```

日志可能包含请求参数、资源属性或敏感信息。共享前必须脱敏，并在排障后删除。

## 何时升级为支持问题

如果本地配置、权限和网络都确认无误，但仍出现 provider panic、schema 不一致、API 返回异常或远端状态无法收敛，提交问题时附带：

- 最小可复现 HCL。
- `terraform version`。
- provider source 和版本。
- 脱敏后的错误日志。
- 相关 ZStack 资源 UUID 和状态。
