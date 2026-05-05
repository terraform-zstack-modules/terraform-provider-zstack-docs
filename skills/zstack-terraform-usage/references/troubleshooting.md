# Troubleshooting

Common issues:

- Provider download failure: verify provider source and registry access.
- Authentication failure: check `host`, `port`, AccessKey values, and network reachability.
- Data source returns no resources: verify UUID/name, resource status, and filters.
- `name_pattern` returns multiple resources: prefer UUID or exact name.
- VM creation fails: verify image, L3 network, instance offering, and static IP availability.
- Security group does not work: verify attachment to VM NIC and rule direction/priority/state.
- Import wants replacement: import does not generate full HCL; align resource block with remote object before apply.
- Load balancer does not forward traffic: verify VIP network reachability, listener ports, backend security group/firewall, and server group membership.
- Script execution fails: verify VM state, script type, encoding type, timeout, and guest execution requirements.
- IAM AccessKey issues: save generated secrets immediately and keep outputs sensitive.
- Monitoring notification does not trigger: verify metric namespace/name, threshold, endpoint state, and webhook reachability.
- Scheduler fails: verify job type, target resource UUID, trigger type, cron/interval, and target resource state.
- Global config issue: inspect current/default values and restore previous value if platform behavior changes.
- License upload fails: verify management node UUID and preserve license text formatting.
- Backup/CDP fails: verify backup storage type, resource UUIDs, capacity, bandwidth, and CDP task type.
