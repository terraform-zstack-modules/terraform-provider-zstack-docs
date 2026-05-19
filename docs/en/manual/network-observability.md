# Network Observability

Network observability covers traffic collection, port mirroring, and network
troubleshooting. These configurations depend on network paths and collection
systems, so production use requires confirming collector address, ports, mirror
network, and endpoint format.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_flow_meter` | resource | Create traffic metering/export configuration, including collection type, server, port, and version. |
| `zstack_flow_collector` | resource | Create traffic collector configuration and send flow meter data to the collector service. |
| `zstack_port_mirror` | resource | Create a port mirror base object to copy selected network traffic. |
| `zstack_port_mirror_session` | resource | Create a port mirror session, defining source endpoint, destination endpoint, and mirror relationship. |

## Flow Meter / Collector

```hcl
resource "zstack_flow_meter" "netflow" {
  type    = var.flow_meter_type
  server  = var.flow_meter_server
  port    = var.flow_meter_port
  version = var.flow_meter_version
}

resource "zstack_flow_collector" "collector" {
  flow_meter_uuid = zstack_flow_meter.netflow.uuid
  server          = var.flow_collector_server
  port            = var.flow_collector_port
}
```

## Port Mirror

Port mirror requires a mirror network UUID, and a session specifies source and
destination endpoints.

Related example:
[examples/common/21-network-observability](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/21-network-observability).
