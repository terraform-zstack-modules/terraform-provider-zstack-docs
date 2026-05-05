# Load Balancer

Load balancer scenarios create a service entry with VIP, load balancer,
listener, and server group resources.

Common resources:

- `zstack_vip`
- `zstack_load_balancer`
- `zstack_load_balancer_listener`
- `zstack_lb_server_group`

## Workflow

1. Confirm the public L3 network for VIP.
2. Create VIP.
3. Create load balancer.
4. Create server group and listener.
5. Add backend binding according to the customer environment and provider
   support.

See `examples/common/11-load-balancer-web`.

## Troubleshooting

If traffic does not pass, check VIP reachability, listener port, backend port,
VM firewall rules, and security group rules.
