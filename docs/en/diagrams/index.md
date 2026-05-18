# Screenshots & Diagrams

This section publishes diagrams for the customer documentation package.
Console screenshots should be added only after they are captured from a real
ZStack environment and sanitized.

## Architecture Diagrams

```mermaid
flowchart LR
  user[User or CI/CD] --> terraform[Terraform CLI]
  terraform --> provider[ZStack Provider 1.1.3]
  provider --> api[ZStack API]
  api --> compute[VMs]
  api --> network[Networks]
  api --> storage[Storage]
  api --> iam[IAM / AccessKey]
```

```mermaid
flowchart TD
  init[terraform init] --> plan[terraform plan]
  plan --> review[Review changes]
  review --> apply[terraform apply]
  apply --> state[State]
  state --> plan
```
