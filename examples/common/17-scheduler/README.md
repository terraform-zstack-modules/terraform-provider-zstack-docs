# 17-scheduler

Creates a scheduler job and trigger.

Scheduler resources execute actions against target resources. Confirm the job
`type`, target resource UUID, and trigger semantics in your ZStack environment
before applying.

## Inputs

Set the target resource UUID, job type, trigger type, cron expression, and names
in `terraform.tfvars`. Confirm the selected job type is supported by the target
ZStack environment.

## Run

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

## Cleanup

Run `terraform destroy` when the scheduler job and trigger should be removed.
