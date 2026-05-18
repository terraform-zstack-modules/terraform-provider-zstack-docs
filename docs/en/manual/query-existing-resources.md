# Query Existing Resources

Use data sources before creating VMs, data volumes, security group attachments,
VIP/EIP, load balancers, VPCs, or administrator resources. This page lists all
data sources registered by provider `1.1.3` and marks their recommended priority
and usage frequency.

Priority guide:

- **Foundation first**: learn these first when connecting to an environment.
  VM and most examples depend on them.
- **Common extension**: frequently used by networking, storage, security group,
  scripts, and tag workflows.
- **Scenario-specific**: used only in the matching capability area, such as load
  balancer, port forwarding, affinity group, or auto scaling.
- **Admin/specialized**: platform administrator or specialized capabilities,
  usually requiring extra permissions and change review.

## Complete Data Source Index

| Data source | Priority | Frequency | Purpose |
|---|---|---|---|
| `zstack_images` | Foundation first | High | Query images for VM creation or image management workflows. |
| `zstack_l3networks` | Foundation first | High | Query L3 networks for VM NICs, VIP/EIP, VPC, and network resources. |
| `zstack_instance_offerings` | Foundation first | High | Query VM compute offerings for CPU and memory sizing. |
| `zstack_disk_offerings` | Foundation first | Common | Query disk offerings for data volumes, image, or backup-related workflows. |
| `zstack_zone` | Foundation first | Common | Query zones to confirm where resources are placed. |
| `zstack_clusters` | Foundation first | Common | Query clusters for placement or host-scope decisions. |
| `zstack_hosts` | Foundation first | Common | Query physical hosts for placement or troubleshooting. |
| `zstack_instances` | Common extension | Common | Query existing VMs for EIP binding, security group attachment, import, or troubleshooting. |
| `zstack_l2networks` | Common extension | Common | Query L2 networks for L3, VPC, or advanced networking scenarios. |
| `zstack_virtual_routers` | Common extension | Common | Query virtual routers for VPC, route table, and route entry context. |
| `zstack_vips` | Common extension | Common | Query VIPs for EIP, load balancer, port forwarding, or public entry diagnostics. |
| `zstack_eips` | Common extension | Common | Query existing EIPs for public access binding, migration, or troubleshooting. |
| `zstack_primary_storages` | Common extension | Common | Query primary storage for capacity, type, or placement context. |
| `zstack_backup_storages` | Common extension | Common | Query image/backup storage for images, image import, backup, or CDP workflows. |
| `zstack_volumes` | Common extension | Common | Query existing data volumes for attachment, import, snapshot, or backup workflows. |
| `zstack_volume_snapshots` | Common extension | Common | Query volume snapshots for restore, audit, or snapshot management workflows. |
| `zstack_networking_secgroups` | Common extension | Common | Query security groups for VM NIC attachment or security group governance. |
| `zstack_networking_secgroup_rules` | Common extension | Common | Query security group rules for audit, migration, or conflict diagnostics. |
| `zstack_tags` | Common extension | Common | Query tags for resource governance, cost ownership, or migration checks. |
| `zstack_user_tags` | Common extension | Common | Query user tags for business metadata governance or migration checks. |
| `zstack_ssh_key_pairs` | Common extension | Common | Query SSH key pairs for VM initialization or login access workflows. |
| `zstack_instance_scripts` | Common extension | Common | Query VM initialization/execution scripts for day-1 initialization or diagnostics. |
| `zstack_accounts` | Scenario-specific | On demand | Query accounts for IAM, permission boundary, or automation identity governance. |
| `zstack_iam2_projects` | Scenario-specific | On demand | Query IAM2 projects for project-level permission and automation identity workflows. |
| `zstack_affinity_groups` | Scenario-specific | On demand | Query affinity groups for VM placement strategy or HA deployment. |
| `zstack_auto_scaling_groups` | Scenario-specific | On demand | Query auto scaling groups for elasticity governance or troubleshooting. |
| `zstack_disks` | Scenario-specific | On demand | Query disk objects for existing disk audit or low-level disk diagnostics. |
| `zstack_l2vlan_networks` | Scenario-specific | On demand | Query VLAN L2 networks for VLAN and L3 network construction. |
| `zstack_reserved_ips` | Scenario-specific | On demand | Query reserved IPs for address planning or conflict diagnostics. |
| `zstack_subnet_ip_ranges` | Scenario-specific | On demand | Query subnet IP ranges for L3 network address pool confirmation and planning. |
| `zstack_load_balancers` | Scenario-specific | On demand | Query load balancers for LB migration, binding, or troubleshooting. |
| `zstack_load_balancer_listeners` | Scenario-specific | On demand | Query LB listeners for port listening, backend binding, or troubleshooting. |
| `zstack_port_forwarding_rules` | Scenario-specific | On demand | Query port forwarding rules for public entry migration or conflict diagnostics. |
| `zstack_virtual_router_images` | Scenario-specific | On demand | Query virtual router images for VPC/VR foundation construction. |
| `zstack_virtual_router_offerings` | Scenario-specific | On demand | Query virtual router offerings for VPC/VR resource construction. |
| `zstack_global_configs` | Admin/specialized | Controlled | Query current and default global config values for controlled admin changes. |
| `zstack_license_authorized_capacity` | Admin/specialized | Controlled | Query license authorized capacity for capacity audit or license operations. |
| `zstack_license_authorized_nodes` | Admin/specialized | Controlled | Query license authorized nodes for node authorization audit or license operations. |
| `zstack_mn_nodes` | Admin/specialized | Controlled | Query management nodes for platform operations, license, or HA diagnostics. |
| `zstack_sdn_controllers` | Admin/specialized | Controlled | Query SDN controllers for SDN-specific networking capabilities. |
| `zstack_gpu_devices` | Admin/specialized | Controlled | Query GPU devices for GPU pools, scheduling, or hardware diagnostics. |
| `zstack_hook_scripts` | Admin/specialized | Controlled | Query hook scripts for platform scripts or compatibility diagnostics. |
| `zstack_instance_guest_tools` | Admin/specialized | Controlled | Query VM guest tools state for scripts, guest capability, or troubleshooting. |

## Lookup Strategy

| Method | Use case | Guidance |
|---|---|---|
| `uuid` | Automation, CI/CD, known resource UUID | Most stable; prefer it when known |
| `name` | Human-authored examples, unique names | Common in customer examples |
| `name_pattern` | Fuzzy lookup and environment discovery | Use carefully and always review matched results |
| `filter` | Narrow by state, type, architecture, or similar fields | Useful for reducing candidate sets |

## Example

For first-time environment validation, source only the root `.env`
authentication variables and run
[examples/common/02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources). The example intentionally queries only foundation-first data sources so the first run does not produce excessive output. It uses broad discovery patterns by default and outputs candidate resources for later examples.

```hcl
data "zstack_images" "ubuntu" {
  name = var.image_name
}

data "zstack_l3networks" "default" {
  name = var.l3_network_name
}

data "zstack_instance_offerings" "small" {
  name = var.instance_offering_name
}
```

## Automation Guidance

If automation already has the UUID, use it directly:

```hcl
data "zstack_l3networks" "selected" {
  uuid = var.l3_network_uuid
}
```

Avoid broad patterns such as `name_pattern = "%Ubuntu%"` in automation. They
can match multiple images and lead to unpredictable selection.

## Related Example

See [examples/common/02-query-existing-resources](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/02-query-existing-resources).
