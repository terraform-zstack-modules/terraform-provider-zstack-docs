# English Translation Tracker

This tracker keeps Chinese and English documentation aligned without blocking
the quality gate on prose length alone.

Status values:

- `Aligned`: English page covers the same delivery-critical guidance as Chinese.
- `Summary`: English page is usable but intentionally shorter.
- `Needs Expansion`: English page lacks scenario detail, risk notes, or examples.

| Area | Chinese Path | English Path | Status | Notes |
|---|---|---|---|---|
| Overview | `docs/zh/index.md` | `docs/en/index.md` | Summary | Keep provider baseline and example entry points aligned. |
| Getting Started | `docs/zh/manual/getting-started.md` | `docs/en/manual/getting-started.md` | Summary | Expand environment preparation and first-run flow when needed. |
| Authentication | `docs/zh/manual/authentication.md` | `docs/en/manual/authentication.md` | Aligned | AccessKey-first guidance is present in both languages. |
| Query Existing Resources | `docs/zh/manual/query-existing-resources.md` | `docs/en/manual/query-existing-resources.md` | Summary | Review query result inspection guidance before external release. |
| Create VM | `docs/zh/manual/create-vm.md` | `docs/en/manual/create-vm.md` | Summary | Keep `network_interfaces` guidance aligned. |
| Networking | `docs/zh/manual/networking.md` | `docs/en/manual/networking.md` | Summary | Expand VPC, SG, and EIP caveats as customer scenarios arrive. |
| Storage | `docs/zh/manual/storage.md` | `docs/en/manual/storage.md` | Summary | Keep attach/detach risk notes aligned. |
| Image | `docs/zh/manual/image.md` | `docs/en/manual/image.md` | Summary | Expand image creation and backup storage prerequisites. |
| IAM | `docs/zh/manual/iam.md` | `docs/en/manual/iam.md` | Summary | Keep sensitive output and AccessKey handling aligned. |
| Load Balancer | `docs/zh/manual/load-balancer.md` | `docs/en/manual/load-balancer.md` | Summary | Expand listener/server group workflow if published externally. |
| Monitoring & Notification | `docs/zh/manual/monitoring-notification.md` | `docs/en/manual/monitoring-notification.md` | Summary | Validate metric/action details with a real environment. |
| Admin Operations | `docs/zh/manual/admin-operations.md` | `docs/en/manual/admin-operations.md` | Summary | Global config, scheduler, and license pages need careful risk parity. |
| Backup & CDP | `docs/zh/manual/backup-cdp.md` | `docs/en/manual/backup-cdp.md` | Summary | Expand prerequisites before customer delivery. |
| Network Observability | `docs/zh/manual/network-observability.md` | `docs/en/manual/network-observability.md` | Summary | Validate collector and mirror fields with real environment. |
| Advanced Network | `docs/zh/manual/advanced-network.md` | `docs/en/manual/advanced-network.md` | Summary | Expand IPsec and policy route caveats with customer scenarios. |
| Resource Stack | `docs/zh/manual/resource-stack.md` | `docs/en/manual/resource-stack.md` | Summary | Expand template lifecycle notes before external release. |
| Specialized Resources | `docs/zh/manual/specialized-resources.md` | `docs/en/manual/specialized-resources.md` | Needs Expansion | P3 resources are indexed only; expand after concrete customer scenarios. |
| Best Practices | `docs/zh/best-practices/index.md` | `docs/en/best-practices/index.md` | Summary | Keep secrets, state, UUID, and provider baseline guidance aligned. |
| Troubleshooting | `docs/zh/troubleshooting/index.md` | `docs/en/troubleshooting/index.md` | Summary | Add more English symptom/remediation pairs as validation finds issues. |
| FAQ | `docs/zh/faq/index.md` | `docs/en/faq/index.md` | Summary | Keep customer-facing answers synchronized. |
| Migration | `docs/zh/migration/index.md` | `docs/en/migration/index.md` | Summary | English migration overview is usable but shorter than the updated Chinese page. |
