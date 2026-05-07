# Scenario Patterns

## Query Before Create

Query existing image, L3 network, and instance offering before creating a VM.

Use:

- `data "zstack_images"`
- `data "zstack_l3networks"`
- `data "zstack_instance_offerings"`

## VM Networking

Use:

```hcl
network_interfaces = [
  {
    l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
    default_l3      = true
    static_ip       = var.static_ip
  }
]
```

## Security Group

Use:

- `zstack_networking_secgroup`
- `zstack_networking_secgroup_rule`
- `zstack_networking_secgroup_attachment`

Attach the security group to the VM NIC UUID.

## Volume

Use `zstack_volume` with `vm_instance_uuid` when the volume should have an independent lifecycle.

## Import

Use CLI import or Terraform 1.5+ import blocks. After import, run `terraform plan` and adjust HCL until no unintended replacement remains.

## Load Balancer

Use:

- `zstack_vip`
- `zstack_load_balancer`
- `zstack_load_balancer_listener`
- `zstack_lb_server_group`

Output VIP, load balancer, listener, and server group UUIDs.

## VM Initialization Scripts

Use:

- `zstack_ssh_key_pair`
- `zstack_instance_scripts`
- `zstack_instance_scripts_execution`

Do not place secrets in script content.

## Tags

Use `zstack_tag` and `zstack_tag_attachment`. Start with simple tags for environment, owner, application, and cost center.

## IAM / AccessKey

Use `zstack_account`, `zstack_iam2_project`, `zstack_iam2_virtual_id`, and `zstack_access_key`. Mark all passwords and AccessKey outputs as sensitive.

## Monitoring / Notification

Use `zstack_alarm`, `zstack_sns_topic`, `zstack_sns_email_endpoint`, and `zstack_webhook`. Metric namespaces and names must come from a real ZStack environment.

## Scheduler

Use `zstack_scheduler_job` and `zstack_scheduler_trigger`. Do not invent job types. Require a target resource UUID and confirm trigger semantics.

## Global Config

Query with `data "zstack_global_configs"` first. Only manage `zstack_global_config` after confirming category, name, current value, default value, and impact.

## License

Use `data "zstack_license_authorized_capacity"` and `data "zstack_license_authorized_nodes"` for read-only checks. Use `zstack_license` only with sensitive license text and a confirmed management node UUID.

## Backup / CDP

Use `zstack_cdp_policy`, `zstack_cdp_task`, `zstack_volume_backup`, `zstack_database_backup`, and optionally `zstack_zbox_backup`. Require explicit resource UUIDs and confirmed backup storage type.

## Network Observability

Use `zstack_flow_meter`, `zstack_flow_collector`, `zstack_port_mirror`, and `zstack_port_mirror_session`. Require confirmed collector server, ports, mirror network UUID, and endpoint formats.

## Advanced Network

Use `zstack_ipsec_connection`, `zstack_policy_route_rule_set`, and `zstack_policy_route_rule`. Treat IPsec auth keys as sensitive and never invent peer or route values.

## Specialized Resources

P3 resources should be indexed first and generated only after the customer confirms the environment, external system, hardware, credentials, and lifecycle expectations. Use variables for UUIDs and secrets; do not invent vendor/device details.
