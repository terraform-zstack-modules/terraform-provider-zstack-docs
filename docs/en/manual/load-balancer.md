# Load Balancer

Load Balancer is a core production service entry capability. It is usually used
with VIP, listener, server group, and backend VMs.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vip` | resource | Create an entry VIP as the access address for the load balancer. |
| `zstack_load_balancer` | resource | Create a load balancer instance, bind the VIP, and carry listeners. |
| `zstack_load_balancer_listener` | resource | Create a listener, defining frontend protocol/port and backend port. |
| `zstack_lb_server_group` | resource | Create a backend server group for backend VM/NIC members. |

## Basic Model

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

## Guidance

- Clearly distinguish the public or entry L3 network used by VIP.
- Manage listener ports and backend ports through variables.
- Output VIP, LB, listener, and server group UUIDs so backend members can be
  connected for the target environment.
- If one LB serves multiple applications, prefer module boundaries around
  listener/server group.

## Related Example

See [examples/common/11-load-balancer-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web).
