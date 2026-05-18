# Debugging And Diagnostics

Use this page to troubleshoot Terraform and ZStack provider issues. Collect
facts first, then decide whether the cause is configuration, network, permission,
schema, or remote resource state.

## Collect Facts First

Record:

- Terraform CLI version.
- ZStack provider source and version.
- Exact command and working directory.
- ZStack management node host and port.
- Authentication method, with real credentials hidden.
- Related resource names, UUIDs, and statuses.
- Sanitized plan, error message, and provider logs.

Do not send raw AccessKey secrets, account passwords, license text, private
keys, tokens, or state files to others.

## Initialization Issues

```bash
terraform init
terraform providers
```

Check:

- Whether `required_providers.zstack.source` is expected.
- Whether offline environments load the provider mirror configuration.
- Whether `.terraform.lock.hcl` matches the documented or project version
  constraint.

## Authentication Issues

Check environment variables:

```bash
env | grep '^ZSTACK_'
```

Confirm the runner can reach the management node and the AccessKey has
permissions for target resources. Do not mix AccessKey and account/password in
one provider configuration unless you have a clear reason.

## Data Source Issues

If a query finds no resource:

- Confirm the resource exists in the ZStack console.
- Prefer exact `uuid` lookup.
- If using `name`, confirm the name is unique.
- If using `name_pattern`, output and review matched results.
- Check resource state, for example image `Ready` or `Enabled`.

## Plan Issues

`terraform plan` is the primary diagnostic entry point. Check for:

- Replacement.
- Unexpected deletion.
- Administrator-level resource changes.
- Missing HCL fields after import.
- Drift caused by console-side changes.

Do not apply when the reason is unclear.

## Debug Logs

For detailed provider logs, temporarily enable:

```bash
TF_LOG=DEBUG TF_LOG_PATH=terraform.log terraform plan
```

Logs can contain request parameters, resource attributes, or sensitive values.
Sanitize before sharing and delete logs after troubleshooting.

## When To Escalate

If local configuration, permissions, and network access are confirmed but you
still see provider panics, schema mismatch, API anomalies, or remote state that
cannot converge, include:

- Minimal reproducible HCL.
- `terraform version`.
- Provider source and version.
- Sanitized error logs.
- Related ZStack resource UUIDs and statuses.
