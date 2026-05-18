# Terraform 运行流程

本页给出从初始化到清理的标准命令顺序，以及在团队环境中如何控制变更。

## 推荐目录结构

```text
project/
  versions.tf
  providers.tf
  variables.tf
  main.tf
  outputs.tf
  terraform.tfvars
```

小示例可以合并到 `main.tf`，但生产项目建议拆分 provider、变量、资源和输出。

## 基础命令顺序

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

对示例资源做清理：

```bash
terraform destroy
```

在共享环境中，不要跳过 `plan` 直接 `apply`。如果 plan 中出现 replacement、删除或高风险管理员资源，先停止评审。

## 受控 Apply

生产环境建议保存 plan 文件，并让 apply 使用已评审的 plan：

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

plan 文件可能包含敏感值，应按敏感文件处理，不要提交到 Git。

## 变量文件

本地示例通常从模板开始：

```bash
cp terraform.tfvars.example terraform.tfvars
```

`terraform.tfvars` 中只能放目标环境值。真实凭证优先通过环境变量或 secret store 注入。

## Import 流程

纳管已有资源时，推荐顺序：

1. 写出最小 resource block。
2. 执行 `terraform import` 或使用 import block。
3. 执行 `terraform plan`。
4. 按 plan 补齐 HCL，直到 no-op 或只剩明确接受的差异。
5. 再进入 apply 流程。

不要把 import 后的首次 replacement 直接当成正常变更。

## CI/CD 流程

CI 至少执行：

```bash
terraform fmt -check
terraform validate
terraform plan
```

生产 apply 应加审批、变更窗口、state 访问控制和凭证隔离。普通 pull request 流程不应自动 apply 到真实 ZStack 环境。
