# 监控与通知

监控和通知用于把资源状态和业务事件连接到运维响应流程。

## 常用资源

| Terraform 对象 | 类型 | 用途 |
|---|---|---|
| `zstack_alarm` | resource | 创建告警规则，基于 metric namespace/name、阈值和比较条件触发告警。 |
| `zstack_sns_topic` | resource | 创建通知主题，用于组织告警消息投递目标。 |
| `zstack_sns_email_endpoint` | resource | 创建邮件通知端点，把告警发送到邮箱。 |
| `zstack_sns_http_endpoint` | resource | 创建 HTTP 通知端点，把告警推送到 HTTP 服务。 |
| `zstack_webhook` | resource | 创建 webhook，用于对接外部运维、告警或自动化系统。 |
| `zstack_monitor_template` | resource | 创建监控模板，用于复用一组监控规则配置。 |
| `zstack_monitor_group` | resource | 创建监控组，用于组织被监控资源或模板应用范围。 |

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
- Provider `1.1.3` 创建 SNS email endpoint 时需要
  `platform_uuid`；先在目标环境确认 SNS platform UUID。
- 通知端点和告警规则应分开管理，避免修改告警时误删通知端点。
- Webhook URL、opaque payload 中可能包含敏感信息，应作为敏感变量管理。
- 当前示例只创建基础对象；告警和通知动作的绑定方式应按目标环境确认。

## 对应示例

见 [examples/common/16-monitoring-notification](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification)。
