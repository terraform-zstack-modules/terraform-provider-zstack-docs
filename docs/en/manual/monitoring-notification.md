# Monitoring And Notification

Monitoring and notification examples cover alarm, SNS topic, email endpoint,
HTTP endpoint, and webhook primitives.

Common resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_alarm` | resource | Create an alarm rule based on metric namespace/name, threshold, and comparison operator. |
| `zstack_sns_topic` | resource | Create a notification topic for routing alarm messages. |
| `zstack_sns_email_endpoint` | resource | Create an email endpoint for notification delivery. |
| `zstack_sns_http_endpoint` | resource | Create an HTTP endpoint for notification delivery. |
| `zstack_webhook` | resource | Create a webhook for external operations, alerting, or automation systems. |
| `zstack_monitor_template` | resource | Create a reusable monitoring template. |
| `zstack_monitor_group` | resource | Create a monitor group for organizing monitored resources or template scope. |

## Guidance

- Metric namespace and metric name must come from the real ZStack environment.
- Do not invent metric names when generating automation.
- Provider `1.1.3` requires `platform_uuid` when creating SNS email endpoints;
  confirm the SNS platform UUID in the target environment before applying.
- Webhook URLs should be supplied through secure variables or CI/CD secret
  stores when they contain tokens.
- Test notification endpoints before production use.

See [examples/common/16-monitoring-notification](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/16-monitoring-notification).
