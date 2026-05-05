# Network Observability

Network observability resources help collect flow and mirror traffic for
troubleshooting.

Common resources:

- `zstack_flow_meter`
- `zstack_flow_collector`
- `zstack_port_mirror`
- `zstack_port_mirror_session`

## Guidance

- Confirm collector server address and port.
- Confirm flow meter type and version with the collector.
- Confirm mirror network UUID and endpoint formats.
- Do not reuse the example values without checking the customer network design.

See `examples/common/21-network-observability`.
