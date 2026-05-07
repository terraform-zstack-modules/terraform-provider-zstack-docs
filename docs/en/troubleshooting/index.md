# Troubleshooting

## Provider Download Fails

- Check `required_providers.zstack.source`.
- Use `ZStack-Robot/zstack` for the public Terraform Registry.
- Use the exact private source shown by the ZStack platform or private registry.
- Make sure Terraform CLI can reach the selected registry or mirror.

## Authentication Fails

- Check `ZSTACK_HOST`, `ZSTACK_PORT`, AccessKey ID, and AccessKey Secret.
- Make sure the Terraform runner can reach the ZStack management node.
- Confirm the AccessKey has permission for the target resources.
- Do not mix AccessKey and account/password authentication in the same provider
  configuration unless you have a specific reason.

## Data Source Finds No Resource

- Confirm the resource name or UUID in the ZStack console.
- Prefer `uuid` for exact lookup.
- If using `name_pattern`, output and review the matched resources.
- Check resource status, for example image `Ready` or `Enabled`.

## VM Creation Fails

- Confirm image, L3 network, and instance offering exist.
- Check `network_interfaces` and the selected L3 UUID.
- For static IP failures, confirm the IP is in range and not already used.
- Do not set both `instance_offering_uuid` and `cpu_num` plus `memory_size`.

## Import Plan Wants Replacement

- Import writes state, but it does not generate complete HCL.
- Fill in the resource block and run `terraform plan` again.
- Do not run `terraform apply` until the plan is no-op or only contains
  intentionally accepted changes.

## Load Balancer Does Not Work

- Confirm the VIP L3 network is reachable.
- Check listener frontend port and backend port.
- Check backend VM firewall and security group rules.
- Output and verify LB, listener, and server group UUIDs.

## Admin Operations Are Risky

- For global config, query current value and default value before managing it.
- For AccessKey creation with provider `1.1.3`, set `user_uuid`.
- For SNS email endpoints with provider `1.1.3`, confirm `platform_uuid` in the
  target environment.
- For license authorized nodes with provider `1.1.3`, do not use
  `name_pattern`; use schema-supported `uuid` or `filter`.
- For license upload, keep license text in a secret store.
- For backup and CDP, confirm backup storage type, capacity, and bandwidth.
