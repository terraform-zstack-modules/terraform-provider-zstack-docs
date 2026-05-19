# FAQ

## Which Provider Source Should I Use?

Use `ZStack-Robot/zstack` for customer-facing documentation and public examples.
If you are developing the provider itself and need to test a local build or
development registry, configure the source or Terraform CLI development
override for that development environment. Offline customer environments should
prefer a Terraform provider mirror that serves the same provider source and
version; do not casually change source names in delivery examples.

## Why Is AccessKey Recommended?

AccessKey authentication is better suited for automation and permission
management. Account/password authentication is kept as a compatibility option.

## When Should I Use UUID Or Name?

Prefer UUID for automation scripts and CI/CD configuration. Use exact names only
when human-authored configurations guarantee uniqueness. Use `name_pattern` only
for exploration and debugging.

## Can Examples Be Used Directly In Production?

Examples are runnable starting points, not complete production modules. Add
backend configuration, variable validation, permission boundaries, naming rules,
tags, and approval workflows before production use.

## Should VM Creation Use `l3_network_uuids`?

No for new configurations. Use `network_interfaces`, which can express the
default NIC, static IP, and multi-NIC requirements.

## How Do I Manage Multiple Environments?

Use different variable files, workspaces, or separate directories together with
a remote backend. Do not mix unrelated environments in one state.

## How Do I Import Existing Resources?

Write the resource block first, then run `terraform import` or use an import
block. After import, run `terraform plan` and fix differences.

## Does Offline Deployment Work?

Yes. Prefer a Terraform provider mirror for the target `ZStack-Robot/zstack`
version, and confirm that the runner can fetch the provider from the internal
mirror.

## How Should I Upgrade Provider Versions?

This documentation and the runnable examples are based on provider `1.1.3`.
When upgrading, update `required_providers.zstack.version` consistently, run
`terraform init -upgrade`, and then run `terraform plan` for each scenario that
will be published or demonstrated. Treat unverified new versions as migration
work; do not batch replace versions and apply directly.

## What Changed In Provider 1.1.3?

`zstack_access_key` requires `user_uuid`, `zstack_sns_email_endpoint` requires
`platform_uuid`, and `zstack_license_authorized_nodes` no longer supports
`name_pattern`. Resource orchestration and orchestration templates are canceled,
so related examples are no longer maintained.

## Why Does The Load Balancer Example Not Include Complete Backend Binding?

Backend membership depends on the customer environment, provider version, and
network model. The current example creates VIP, load balancer, listener, and
server group first, and outputs UUIDs so backend binding can be completed for
the target environment.

## What Are Initialization Scripts Good For?

They are suitable for day-1 initialization, such as installing packages,
configuring guest agents, or writing baseline configuration. They are not
suitable for long-lived secrets, private keys, or large unaudited scripts.

## How Should Tags Be Designed?

Start with a small shared set of standard tags: `environment`, `owner`,
`application`, and `cost-center`. Do not let each team invent a separate naming
system.

## Can The IAM Example Run Directly In Production?

Not recommended. IAM examples create accounts, virtual identities, and
AccessKeys. Confirm permission boundaries, password policy, and secret storage
before running them.

## Can Global Config Be Managed By Terraform Directly?

Yes, but do not apply it directly in production for the first run. Query current
values, default values, and descriptions first, then manage the setting only
after the impact is understood.

## Where Should License Text Be Stored?

Store it in a secret store, CI/CD secret, or local uncommitted sensitive
variable file. Do not commit it to Git and do not print it to ordinary logs.

## Why Do CDP And Backup Examples Have Many `replace-me` Values?

Backup/CDP depends heavily on real resource UUIDs, backup storage type, and
business retention policy. The documentation cannot invent these values for a
customer environment; an administrator must confirm them.

## What Should Scheduler Job Type Be?

It depends on the task types supported by the target ZStack environment. Query
or confirm supported job types before use. Do not guess.

## Can Network Observability Examples Be Reused Directly?

No. Collector address, port, flow meter type, and mirror endpoint format depend
on customer network design and must be confirmed by an administrator.

## Can IPsec Algorithm Fields Be Omitted?

If ZStack and the peer side have default negotiation policies, you can start by
omitting them. In production, document the algorithms, PFS, and transform
protocol used on both sides.
