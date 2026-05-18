# 快速开始

Terraform Provider ZStack 用于把 ZStack 云资源声明为代码，并通过 `plan/apply` 管理变更。

## 前置条件

- Terraform 1.5 或更高版本。
- 可访问的 ZStack 管理节点。
- AccessKey ID 和 AccessKey Secret。
- 已存在的基础资源：镜像、L3 网络、计算规格、磁盘规格。

## 推荐学习顺序

1. 配置 provider 和认证。
2. 查询已有资源。
3. 创建单台 VM。
4. 批量创建 VM。
5. 为 VM 增加静态 IP、安全组和数据盘。
6. 绑定 VIP/EIP 或接入 Load Balancer。
7. 导入已有资源。

## 基础命令

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## 示例

从 [examples/common/01-provider](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/01-provider) 开始。每个示例都包含：

- `main.tf`
- `variables.tf`
- `terraform.tfvars.example`
- `README.md`

复制 `terraform.tfvars.example` 为 `terraform.tfvars` 后填入真实值。不要提交真实 `terraform.tfvars`。
