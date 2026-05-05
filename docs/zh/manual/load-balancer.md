# Load Balancer

Load Balancer 是 P1 生产场景的核心入口能力，通常和 VIP、listener、server group、后端 VM 一起使用。

## 常用资源

- `zstack_vip`
- `zstack_load_balancer`
- `zstack_load_balancer_listener`
- `zstack_lb_server_group`

## 基础模型

```hcl
resource "zstack_vip" "web" {
  name            = var.vip_name
  l3_network_uuid = var.public_l3_network_uuid
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
- 输出 VIP、LB、listener、server group UUID，方便后续接入后端成员。
- 如果一个 LB 服务多个应用，优先按 listener/server group 拆分模块。

## 对应 Example

见 `examples/common/11-load-balancer-web`。
