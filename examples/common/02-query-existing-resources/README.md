# 02-query-existing-resources

Queries existing resources commonly needed before creating VMs. This example is
the first stop after authentication: source the root `.env`, run `terraform
plan`, and review the output before choosing resources for create/import
examples.

- images
- L3 networks
- instance offerings
- disk offerings
- zone
- clusters
- hosts

The default patterns are broad so the example can run with only authentication
variables. Narrow the `*_name_pattern` variables when the result list is too
large. Prefer exact `name` or `uuid` in create examples after discovery.
