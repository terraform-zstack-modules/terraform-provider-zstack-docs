# How It Works

Terraform Provider ZStack converts desired state declared in HCL into ZStack API
calls, and records the relationship between Terraform addresses and ZStack UUIDs
in state.

## Execution Model

1. Terraform reads `.tf` files, variables, and provider constraints.
2. `terraform init` downloads the ZStack provider or loads it from a mirror.
3. `terraform plan` calls data sources and resource read APIs to build a diff.
4. `terraform apply` calls ZStack APIs in dependency order to create, update, or
   delete resources.
5. Terraform writes the result to state.

## Data Sources

Data sources read existing ZStack objects such as images, L3 networks,
offerings, zones, and clusters. They do not create resources, but they affect
the plan result.

If a data source uses an overly broad `name_pattern`, later resources can refer
to the wrong object. Production configurations should prefer `uuid` or unique
`name`.

## Resources

Resources are managed by Terraform lifecycle. After creation, state stores the
corresponding ZStack UUID. Later plans compare:

- Desired values declared in HCL.
- Known values saved in state.
- Current values read from ZStack APIs.

If a field cannot be updated in place by the provider or ZStack API, Terraform
may show replacement. Review the reason before applying replacement.

## State And Drift

State is the core file Terraform uses to decide resource ownership. Do not edit
state manually unless you are following a deliberate recovery procedure.

If someone changes resources in the ZStack console outside Terraform, the next
plan may show drift. First decide whether the console change should be kept,
then update HCL, revert the console change, or accept the Terraform change.

## Import

Import only writes an existing resource into state. It does not generate complete
HCL. After import, run `terraform plan` and fill in the resource block until the
plan converges.

## Sensitive Values

Terraform state and plan files can contain sensitive values. Even when variables
or outputs are marked `sensitive`, do not share state, plan files, or debug logs
as ordinary files.

## Boundaries

The provider calls ZStack APIs. It does not replace change approval, capacity
planning, naming rules, permission design, network security review, or backup
strategy. Production delivery must handle these outside the Terraform project.
