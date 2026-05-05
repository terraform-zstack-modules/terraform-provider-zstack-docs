# Network Observability

P2 网络观测场景用于流量采集、端口镜像和网络排障。此类配置对网络路径和采集系统有依赖，生产使用前必须确认采集器地址、端口、镜像网络和端点格式。

## 常用资源

- `zstack_flow_meter`
- `zstack_flow_collector`
- `zstack_port_mirror`
- `zstack_port_mirror_session`

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

Port mirror 需要 mirror network UUID，并通过 session 指定源端点和目标端点。

对应 example：`examples/common/21-network-observability`。
