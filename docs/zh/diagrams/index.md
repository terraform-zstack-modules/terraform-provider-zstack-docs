# 截图与架构图

本章节用于引用 `assets/diagrams` 和 `assets/screenshots` 中的架构图、流程图和控制台截图。

当前页面只发布可在站点中直接渲染的 Mermaid 架构图。控制台截图需要来自真实 ZStack 环境并完成脱敏后再发布。

## Terraform 与 ZStack 交互架构

```mermaid
flowchart LR
  user[用户 / CI/CD] --> cli[Terraform CLI]
  cli --> state[(Terraform State)]
  cli --> provider[ZStack Terraform Provider]
  provider --> api[ZStack Management Node API]
  api --> compute[云主机 / 计算资源]
  api --> network[网络 / 安全组 / EIP / LB]
  api --> storage[存储 / 镜像 / 备份]
  api --> iam[IAM / AccessKey]

  subgraph repo[文档与代码仓库]
    docs[客户文档]
    examples[examples/common]
  end

  user --> docs
  user --> examples
```

## Terraform 执行流程

```mermaid
flowchart TD
  start[准备 Terraform 配置] --> init[terraform init]
  init --> fmt[terraform fmt]
  fmt --> validate[terraform validate]
  validate --> plan[terraform plan]
  plan --> review{人工审核计划}
  review -- 通过 --> apply[terraform apply]
  review -- 不通过 --> edit[修改配置]
  edit --> fmt
  apply --> state[更新 Terraform State]
  state --> output[查看 outputs / ZStack 控制台]
  output --> destroy{是否清理示例资源}
  destroy -- 是 --> tfDestroy[terraform destroy]
  destroy -- 否 --> keep[保留资源纳管]
```

## Provider 认证配置

```mermaid
flowchart LR
  subgraph inputs[认证输入]
    hcl[HCL provider block]
    env[ZSTACK_* 环境变量]
    secret[CI/CD Secret Store]
  end

  secret --> env
  hcl --> provider[ZStack Provider]
  env --> provider

  provider --> accessKey{认证方式}
  accessKey --> ak[AccessKey 推荐]
  accessKey --> account[Account/Password 兼容]

  ak --> api[ZStack API Client]
  account --> api
```

## VM + L3 + Security Group + EIP

```mermaid
flowchart TB
  tf[Terraform] --> image[data.zstack_images]
  tf --> offering[data.zstack_instance_offerings]
  tf --> l3[data.zstack_l3networks]

  image --> vm[zstack_instance]
  offering --> vm
  l3 --> nic[VM NIC]
  vm --> nic

  sg[zstack_networking_secgroup] --> rule[zstack_networking_secgroup_rule]
  sg --> attach[zstack_networking_secgroup_attachment]
  nic --> attach

  publicL3[Public L3 Network] --> vip[zstack_vip]
  vip --> eip[zstack_eip]
  nic --> eip

  user[外部访问] --> eip
  eip --> nic
```

## Load Balancer Web 场景

```mermaid
flowchart TB
  public[Public L3 Network] --> vip[zstack_vip]
  vip --> lb[zstack_load_balancer]
  lb --> listener[zstack_load_balancer_listener]
  lb --> group[zstack_lb_server_group]

  listener --> group
  group --> vm1[Backend VM 1]
  group --> vm2[Backend VM 2]
  group --> vmn[Backend VM N]

  client[Client] --> vip
```

## VPC 路由场景

```mermaid
flowchart TB
  l2[L2 Network] --> vpc[zstack_vpc]
  vr[Virtual Router] --> vpc
  vpc --> subnet[Subnet CIDR]

  table[zstack_vrouter_route_table] --> entry[zstack_vrouter_route_entry]
  entry --> dest[Destination CIDR]
  entry --> target[Route Target]

  workload[Private Workloads] --> subnet
  subnet --> vr
  vr --> table
```
