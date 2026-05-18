# 网络观测

网络观测场景用于流量采集、端口镜像和网络排障。此类配置对网络路径和采集系统有依赖，生产使用前必须确认采集器地址、端口、镜像网络和端点格式。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_flow_meter` | resource | 创建流量计量/导出配置，定义采集类型、服务器、端口和版本。 |
| `zstack_flow_collector` | resource | 创建流量采集器配置，把 flow meter 数据发送到采集服务。 |
| `zstack_port_mirror` | resource | 创建端口镜像基础对象，用于复制指定网络流量。 |
| `zstack_port_mirror_session` | resource | 创建端口镜像会话，定义源端点、目标端点和镜像关系。 |

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

对应示例：[examples/common/21-network-observability](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/21-network-observability)。
