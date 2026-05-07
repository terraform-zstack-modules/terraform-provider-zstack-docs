# 16-monitoring-notification

Creates monitoring and notification primitives:

- alarm
- SNS topic
- SNS email endpoint
- webhook

Notification wiring can vary by environment. Use the output UUIDs to connect
alarms and endpoints according to your ZStack notification model.
Provider 1.1.3 requires `email_platform_uuid` for SNS email endpoints; discover
or confirm the platform UUID in the target environment before applying.
