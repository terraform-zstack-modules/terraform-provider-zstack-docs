# 02-query-existing-resources

Queries existing resources commonly needed before creating VMs:

- images
- L3 networks
- instance offerings
- disk offerings
- zone
- clusters
- hosts

Prefer `uuid` in automation when the UUID is already known. Use exact `name`
for human-authored examples. Use `name_pattern` only when you intentionally want
fuzzy matching and review the result list.
