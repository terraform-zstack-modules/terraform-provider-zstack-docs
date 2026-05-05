# Monitoring And Notification

Monitoring and notification examples cover alarm, SNS topic, email endpoint,
HTTP endpoint, and webhook primitives.

Common resources:

- `zstack_alarm`
- `zstack_monitor_template`
- `zstack_monitor_group`
- `zstack_sns_topic`
- `zstack_sns_email_endpoint`
- `zstack_sns_http_endpoint`
- `zstack_webhook`

## Guidance

- Metric namespace and metric name must come from the real ZStack environment.
- Do not let an agent invent metric names.
- Webhook URLs should be supplied through secure variables or CI/CD secret
  stores when they contain tokens.
- Test notification endpoints before production use.

See `examples/common/16-monitoring-notification`.
