# 负载均衡

Load Balancer 是生产服务入口的核心能力，通常和 VIP、listener、server group、后端 VM 一起使用。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_vip` | resource | 创建入口 VIP，作为负载均衡器的访问地址。 |
| `zstack_load_balancer` | resource | 创建负载均衡器实例，绑定 VIP 并承载监听器。 |
| `zstack_load_balancer_listener` | resource | 创建监听器，定义前端协议/端口和后端端口。 |
| `zstack_lb_server_group` | resource | 创建后端服务器组，用于组织后端 VM/NIC 成员。 |

## 基础模型

```hcl
data "zstack_l3networks" "public" {
  name_pattern = var.public_l3_network_name_pattern
}

resource "zstack_vip" "web" {
  name            = var.vip_name
  l3_network_uuid = data.zstack_l3networks.public.l3networks[0].uuid
}

resource "zstack_load_balancer" "web" {
  name     = var.load_balancer_name
  vip_uuid = zstack_vip.web.uuid
}

resource "zstack_load_balancer_listener" "http" {
  name               = var.listener_name
  load_balancer_uuid = zstack_load_balancer.web.uuid
  protocol           = "http"
  load_balancer_port = 80
  instance_port      = 8080
}
```

## 建议

- VIP 所在 L3 网络应明确区分公网/入口网络。
- listener 端口和后端端口使用变量管理。
- 输出 VIP、LB、listener、server group UUID，方便按环境接入后端成员。
- 如果一个 LB 服务多个应用，优先按 listener/server group 拆分模块。

## 对应示例

见 [examples/common/11-load-balancer-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web)。
