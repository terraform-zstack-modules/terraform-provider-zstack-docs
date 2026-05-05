# Screenshots & Diagrams

This section records diagrams and screenshot requirements for the customer
documentation package.

## Architecture Diagrams

```mermaid
flowchart LR
  user[User or CI/CD] --> terraform[Terraform CLI]
  terraform --> provider[ZStack Provider 1.1.2]
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

## Screenshot Backlog

- How to create or view AccessKey in the ZStack console.
- How to find resource UUIDs.
- VM, L3 network, security group, EIP, and load balancer views.
- Import workflow evidence from `terraform plan`.
