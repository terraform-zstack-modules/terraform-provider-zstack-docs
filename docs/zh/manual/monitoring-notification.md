# Monitoring & Notification

监控和通知属于 P1 生产场景，用于把资源状态和业务事件连接到运维响应流程。

## 常用资源

- `zstack_alarm`
- `zstack_sns_topic`
- `zstack_sns_email_endpoint`
- `zstack_sns_http_endpoint`
- `zstack_webhook`
- `zstack_monitor_template`
- `zstack_monitor_group`

## 基础模型

```hcl
resource "zstack_sns_topic" "ops" {
  name = var.topic_name
}

resource "zstack_alarm" "cpu" {
  name                = var.alarm_name
  namespace           = var.metric_namespace
  metric_name         = var.metric_name
  comparison_operator = "GreaterThanOrEqualTo"
  threshold           = 80
}
```

## 建议

- 先确认 ZStack 环境中的 metric namespace 和 metric name。
- 通知端点和告警规则应分开管理，避免修改告警时误删通知端点。
- Webhook URL、opaque payload 中可能包含敏感信息，应作为敏感变量管理。
- 第一版 example 只创建基础对象；告警和通知动作的绑定方式按客户环境再补充。

## 对应 Example

见 `examples/common/16-monitoring-notification`。
