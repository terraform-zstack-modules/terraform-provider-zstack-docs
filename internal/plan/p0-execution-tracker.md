# P0 执行跟踪

状态说明：

- `Not Started`: 尚未开始。
- `In Progress`: 正在执行。
- `Done`: 已完成文档或示例落地。
- `Blocked`: 被环境、schema 或外部依赖阻塞。

| # | P0 子项 | 状态 | 文档路径 | Examples 路径 | 来源 | 验证 | 备注 |
|---|---|---|---|---|---|---|---|
| 1 | Provider/Auth | Done | `docs/zh/manual/authentication.md` | `examples/common/01-provider` | provider schema, `examples/provider/accesskey` | `terraform fmt` | 覆盖 AccessKey、账号密码、环境变量、provider source；未连接真实环境 apply |
| 2 | Query Existing Resources | Done | `docs/zh/manual/query-existing-resources.md` | `examples/common/02-query-existing-resources` | provider data-source docs/tests | `terraform fmt` | 镜像、L3、规格、zone、cluster、host；未连接真实环境 apply |
| 3 | Create VM | Done | `docs/zh/manual/create-vm.md` | `examples/common/03-create-vm` | `docs/resources/instance.md`, instance tests | `terraform fmt` | 使用 `network_interfaces`；未连接真实环境 apply |
| 4 | Batch VMs | Done | `docs/zh/manual/create-vm.md` | `examples/common/04-create-10-vms` | `_local/create-10-vms` | `terraform fmt` | 使用 `for_each`；未连接真实环境 apply |
| 5 | VM + Network Interfaces + Static IP | Done | `docs/zh/manual/networking.md` | `examples/common/03-create-vm`, `examples/common/04-create-10-vms` | instance schema | `terraform fmt` | 覆盖 `default_l3` 和 `static_ip`；未连接真实环境 apply |
| 6 | VM + Security Group | Done | `docs/zh/manual/networking.md` | `examples/common/06-security-group` | security group docs/examples/tests | `terraform fmt` | SG、rule、attachment；未连接真实环境 apply |
| 7 | VM + Volume | Done | `docs/zh/manual/storage.md` | `examples/common/08-volume` | volume docs/examples/tests | `terraform fmt` | 独立 volume + attach；未连接真实环境 apply |
| 8 | Image Query / Image Management | Done | `docs/zh/manual/image.md` | `examples/common/09-image-query-management` | image docs/examples/tests | `terraform fmt` | 查询先于创建；未连接真实环境 apply |
| 9 | Import Existing Resources | Done | `docs/zh/migration/import-existing-resources.md` | `examples/common/10-import-existing-vm` | Terraform import docs, provider resource docs | `terraform fmt` | import block + CLI；未连接真实环境 plan |
| 10 | Best Practices P0 | Done | `docs/zh/best-practices/index.md` | N/A | provider docs + HashiCorp style guidance | 文档检查 | UUID/name/name_pattern、secrets、state、for_each |
| 11 | Troubleshooting P0 | Done | `docs/zh/troubleshooting/index.md` | N/A | provider README/tests/batch reports | 文档检查 | 下载、认证、查询、VM、网络、state |
| 12 | FAQ P0 | Done | `docs/zh/faq/index.md` | N/A | P0 文档 | 文档检查 | 客户高频问题 |
| 13 | zstack-terraform-usage Skill | Done | `skills/zstack-terraform-usage/SKILL.md` | `skills/zstack-terraform-usage/examples` | P0 docs + provider repo | `terraform fmt` | 第一版 skill 骨架 |
