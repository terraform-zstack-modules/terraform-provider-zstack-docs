# Network Observability

Network observability resources help collect flow and mirror traffic for
troubleshooting.

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_flow_meter` | resource | Create flow metering/export configuration with type, server, port, and version. |
| `zstack_flow_collector` | resource | Create collector configuration that sends flow meter data to a collection service. |
| `zstack_port_mirror` | resource | Create a port mirror object for copying selected network traffic. |
| `zstack_port_mirror_session` | resource | Create a port mirror session with source endpoint, destination endpoint, and mirror relationship. |

## Guidance

- Confirm collector server address and port.
- Confirm flow meter type and version with the collector.
- Confirm mirror network UUID and endpoint formats.
- Do not reuse the example values without checking the customer network design.

See [examples/common/21-network-observability](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/21-network-observability).
