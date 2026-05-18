# 02-query-existing-resources

Queries foundation resources commonly needed before creating VMs. This example
is the first stop after authentication: source the root `.env`, run `terraform
plan`, and review the output before choosing resources for create/import
examples.

- images
- L3 networks
- instance offerings
- disk offerings
- zone
- clusters
- hosts

The provider exposes more data sources than this example queries. The complete
priority and frequency table is documented in:

- `docs/zh/manual/query-existing-resources.md`
- `docs/en/manual/query-existing-resources.md`

The default patterns are broad so the example can run with only authentication
variables. Narrow the `*_name_pattern` variables when the result list is too
large. Prefer exact `name` or `uuid` in create examples after discovery.

## Run

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform output
```

This example is read-only. Use the outputs to choose exact names or UUIDs for
later examples.
