# Production Guide

Examples are for learning and provider behavior validation. They are not
production modules. Add the capabilities on this page before using Terraform in
a real ZStack environment.

## Production Readiness Checklist

| Area | Requirement |
|---|---|
| State | Use remote backend, restrict access, and enable backup or version retention |
| Credentials | Inject through secret store or CI/CD secrets; keep them out of Git and normal logs |
| Provider | Pin versions and run scenario-level plans before upgrades |
| Variables | Express environment differences through variables and add required validation |
| Naming and tags | Standardize environment, owner, application, cost center, and related tags |
| Approval | Review plan through human or pipeline policy before apply |
| Change window | Deletion, replacement, and admin resource changes need a controlled window |
| Rollback | Define rollback method, data protection, and irreversible-operation boundaries |

## Environment Isolation

Use separate directories, workspaces, or backends for different environments.
The key rule is a clear state boundary: do not mix unrelated environments in one
state.

Example:

```text
envs/
  dev/
  test/
  prod/
modules/
  vm/
  network/
```

Turn examples into reusable modules only when module boundaries are stable and
the team already has a review workflow.

## Change Workflow

Recommended workflow:

1. Change HCL or variables.
2. Run formatting and validation.
3. Generate a plan.
4. Review replacement, deletion, admin resources, and security group rules.
5. Apply during an approved window.
6. Record the change and key outputs.

Production apply should not be triggered automatically by a normal pull request.

## High-Risk Resources

These resource types need extra review:

- `zstack_global_config`
- License resources
- IAM, account, and AccessKey
- Scheduler
- Backup / CDP
- IPsec, policy route, and VPC route
- Security group ingress rules and public VIP/EIP

If the impact is unclear, validate with a test environment or dedicated
resources first.

## Existing Resource Adoption

Before importing existing resources, confirm ownership, naming, tags, and change
window. After import, iterate on plan until it is no-op or only contains
accepted differences.

Do not let Terraform manage resources still modified by another automation
system unless field ownership is explicit.

## Security And Audit

- Expose only UUIDs, addresses, and states required for diagnostics.
- Mark sensitive outputs with `sensitive = true`.
- Treat plan, state, and logs as sensitive files.
- Security groups and public entry points need trusted CIDRs, business owner,
  and approval records.
- Record operator, time, plan summary, and rollback notes for admin changes.
