# Monitoring And Notification

Monitoring and notification connect resource state and business events to
operations response workflows.

## Common Resources

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_alarm` | resource | Create an alarm rule triggered by metric namespace/name, threshold, and comparison condition. |
| `zstack_sns_topic` | resource | Create a notification topic to organize alarm delivery targets. |
| `zstack_sns_email_endpoint` | resource | Create an email endpoint to send alarms to email. |
| `zstack_sns_http_endpoint` | resource | Create an HTTP endpoint to push alarms to an HTTP service. |
| `zstack_webhook` | resource | Create a webhook for external operations, alerting, or automation systems. |
| `zstack_monitor_template` | resource | Create a monitoring template to reuse a group of monitoring rule settings. |
| `zstack_monitor_group` | resource | Create a monitoring group to organize monitored resources or template scope. |

## Basic Model

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

## Guidance

- Confirm metric namespace and metric name in the target ZStack environment.
- Provider `1.1.3` requires `platform_uuid` when creating SNS email endpoints;
  confirm SNS platform UUID in the target environment first.
- Manage notification endpoints and alarm rules separately to avoid deleting
  endpoints while changing alarms.
- Webhook URLs and opaque payloads may contain sensitive information and should
  be managed as sensitive variables.
- The current example creates only basic objects. Alarm and notification action
  binding should be confirmed for the target environment.

## Related Example

See [examples/common/16-monitoring-notification](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification).
