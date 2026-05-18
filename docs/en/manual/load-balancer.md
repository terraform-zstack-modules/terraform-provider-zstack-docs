# Load Balancer

Load balancer scenarios create a service entry with VIP, load balancer,
listener, and server group resources.

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_vip` | resource | Create the entry VIP used as the load balancer access address. |
| `zstack_load_balancer` | resource | Create a load balancer instance bound to a VIP. |
| `zstack_load_balancer_listener` | resource | Create a listener with frontend protocol/port and backend port settings. |
| `zstack_lb_server_group` | resource | Create a backend server group for VM/NIC members. |

## Workflow

1. Confirm the public L3 network for VIP.
2. Create VIP.
3. Create load balancer.
4. Create server group and listener.
5. Add backend binding according to the customer environment and provider
   support.

See [examples/common/11-load-balancer-web](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/11-load-balancer-web).

## Troubleshooting

If traffic does not pass, check VIP reachability, listener port, backend port,
VM firewall rules, and security group rules.
