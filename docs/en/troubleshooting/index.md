# Troubleshooting

## Provider Download Fails

- Check `required_providers.zstack.source`.
- Use `ZStack-Robot/zstack` for the public Terraform Registry.
- Customer delivery examples default to `ZStack-Robot/zstack`; for offline
  environments, verify that the Terraform provider mirror serves that source and
  version.
- In provider development environments, verify that any development registry
  source or CLI dev override matches the local provider build path.
- Make sure Terraform CLI can reach the selected registry or mirror.

## Authentication Fails

- Check `ZSTACK_HOST`, `ZSTACK_PORT`, AccessKey ID, and AccessKey Secret.
- Make sure the Terraform runner can reach the ZStack management node.
- Confirm the AccessKey has permission for the target resources.
- Do not mix AccessKey and account/password authentication at the same time.

## Data Source Finds No Resource

- Confirm the resource name or UUID in the ZStack console first.
- Prefer `uuid` for exact lookup.
- If using `name_pattern`, output and review the full matching range.
- Check resource status, for example image `Ready` or `Enabled`.

## VM Creation Fails

- Confirm image, L3 network, and instance offering exist.
- Check that `network_interfaces` uses the correct L3 UUID.
- For static IP failures, confirm the IP is in range and not already used.
- Do not set both `instance_offering_uuid` and `cpu_num` plus `memory_size`.

## Security Group Does Not Take Effect

- Confirm the security group is attached to the VM NIC through
  `zstack_networking_secgroup_attachment`.
- Check rule direction: `Ingress` or `Egress`.
- Check `ip_ranges`, `destination_port_ranges`, `priority`, and `state`.

## Import Plan Wants Replacement

- Import does not generate complete HCL.
- Fill in the resource block and run `terraform plan` again.
- Do not run `terraform apply` until the plan is no-op or only contains
  intentionally accepted changes.
- If immutable fields differ, decide whether replacement is acceptable first.
- Do not apply when unsure.

## Load Balancer Does Not Work

- Confirm the VIP L3 network is reachable.
- Check listener `load_balancer_port` and `instance_port`.
- Confirm backend VM firewall and security group allow the backend port.
- Output and verify LB, listener, and server group UUIDs.

## Script Execution Fails

- Check `script_type`, `encoding_type`, and `script_timeout`.
- Confirm target VM state and guest agent/execution channel requirements.
- Do not embed complex long scripts directly in HCL. For production, generate
  them from templates or files.

## IAM / AccessKey Issues

- AccessKey secret is visible only during creation and should be saved
  immediately.
- Provider `1.1.3` requires `user_uuid` when creating `zstack_access_key`.
- Check account, user, and virtual ID permission boundaries.
- Do not print sensitive outputs to ordinary CI logs.

## Alarm Or Notification Does Not Trigger

- Confirm metric namespace and metric name exist in the current environment.
- When creating SNS email endpoints, confirm `platform_uuid` from the real
  environment.
- Check threshold, period, and comparison operator.
- Check whether notification endpoints are enabled and whether webhook URLs are
  reachable.

## Scheduler Does Not Run As Expected

- Confirm `scheduler_type`, `cron`, `scheduler_interval`, and `start_time`.
- Check whether `job_type` is supported by the current environment.
- Check target resource UUID and whether the resource state allows the action.

## Global Config Change Risk

- Query current value, default value, and description first.
- If the impact is unclear, keep `manage_global_config = false`.
- If platform behavior changes after modification, use the change record to
  restore the original value.

## License Upload Fails

- Check management node UUID.
- `zstack_license_authorized_nodes` in provider `1.1.3` does not support
  `name_pattern`; do not reuse old-version parameters.
- Confirm license text is complete and not damaged by newline or escaping
  changes.
- Do not print license content in logs.

## Backup/CDP Fails

- Confirm backup storage UUID type.
- Volume backup requires supported ImageStoreBackupStorage.
- Check CDP resource UUID, task type, capacity, and bandwidth limits.
- ZBox backup depends on a concrete ZBox environment. Use a dry run first.

## Flow / Port Mirror Does Not Collect Data

- Check collector server and port reachability.
- Confirm flow meter type/version is compatible with the collector.
- Check mirror network UUID, source endpoint, and destination endpoint format.

## IPsec Or Policy Routing Does Not Take Effect

- Confirm VIP, peer address, and auth key match the peer-side configuration.
- Check encryption algorithm, authentication algorithm, and PFS settings.
- Check policy route rule route table UUID, rule number, and matching
  conditions.
