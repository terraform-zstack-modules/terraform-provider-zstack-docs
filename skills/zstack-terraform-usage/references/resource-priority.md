# Resource Priority

P0 resources and data sources:

- Provider/Auth: `provider zstack`
- Query: `zstack_images`, `zstack_l3networks`, `zstack_instance_offerings`, `zstack_disk_offerings`, `zstack_zone`, `zstack_clusters`, `zstack_hosts`
- VM: `zstack_instance`
- Networking: `zstack_l3network`, `zstack_l2vlan_network`, `zstack_subnet_ip_range`, `zstack_reserved_ip`
- Security group: `zstack_networking_secgroup`, `zstack_networking_secgroup_rule`, `zstack_networking_secgroup_attachment`
- Storage: `zstack_volume`, `zstack_volume_snapshot`, `zstack_disk_offering`, `zstack_primary_storage`, `zstack_backup_storage`
- Image: `zstack_image`, `zstack_virtual_router_image`, `zstack_image_store_backup_storage`
- Import existing resources with Terraform import.

P1 scenarios:

- VIP/EIP: `zstack_vip`, `zstack_eip`
- Load Balancer: `zstack_load_balancer`, `zstack_load_balancer_listener`, `zstack_lb_server_group`
- VPC/route resources
- SSH/scripts
- Tag
- IAM
- Monitoring/notification

P1 examples in this docs repository:

- `examples/common/11-load-balancer-web`
- `examples/common/12-vpc-routing`
- `examples/common/13-vm-init-scripts`
- `examples/common/14-tags`
- `examples/common/15-iam-access-key`
- `examples/common/16-monitoring-notification`

P2 administrator scenarios:

- Scheduler: `zstack_scheduler_job`, `zstack_scheduler_trigger`
- Global config: `zstack_global_config`, `zstack_global_configs`
- License: `zstack_license`, `zstack_license_authorized_nodes`, `zstack_license_authorized_capacity`
- Backup/CDP: `zstack_cdp_policy`, `zstack_cdp_task`, `zstack_volume_backup`, `zstack_database_backup`, `zstack_zbox_backup`
- Network observability: `zstack_flow_meter`, `zstack_flow_collector`, `zstack_port_mirror`, `zstack_port_mirror_session`
- Advanced network: `zstack_ipsec_connection`, `zstack_policy_route_rule_set`, `zstack_policy_route_rule`
- Resource stack/template: `zstack_resource_stack`, `zstack_stack_template`, `zstack_preconfiguration_template`

P3 specialized resources are indexed but should not be deeply generated without a concrete customer environment:

- Baremetal: `zstack_baremetal_chassis`, `zstack_baremetal_instance`, `zstack_baremetal_pxe_server`
- External/hybrid: `zstack_vcenter`, `zstack_aliyun_proxy_vpc`, `zstack_aliyun_proxy_vswitch`, `zstack_aliyun_nas_access_group`
- Security machines: `zstack_jit_security_machine`, `zstack_san_sec_security_machine`, `zstack_info_sec_security_machine`, `zstack_fi_sec_security_machine`, `zstack_flk_sec_security_machine`
- Storage hardware: `zstack_iscsi_server`, `zstack_nvme_server`, `zstack_ceph_pool`, `zstack_ceph_primary_storage`, `zstack_ceph_backup_storage`
- Other platform: `zstack_directory`, `zstack_dataset`, `zstack_price_table`, `zstack_email_media`, `zstack_log_server`, `zstack_snmp_agent`, `zstack_container_management_endpoint`
