# Screenshots & Diagrams

This section references architecture diagrams, flow diagrams, and console
screenshots for the documentation package.

The current page publishes only Mermaid diagrams that can render directly in the
site. Console screenshots should be added only after they are captured from a
real ZStack environment and sanitized.

## Terraform And ZStack Interaction Architecture

```mermaid
flowchart LR
  user[User / CI/CD] --> cli[Terraform CLI]
  cli --> state[(Terraform State)]
  cli --> provider[ZStack Terraform Provider]
  provider --> api[ZStack Management Node API]
  api --> compute[VMs / Compute Resources]
  api --> network[Networks / Security Groups / EIP / LB]
  api --> storage[Storage / Images / Backup]
  api --> iam[IAM / AccessKey]

  subgraph repo[Documentation And Code Repository]
    docs[Customer Documentation]
    examples[examples/common]
  end

  user --> docs
  user --> examples
```

## Terraform Execution Flow

```mermaid
flowchart TD
  start[Prepare Terraform Configuration] --> init[terraform init]
  init --> fmt[terraform fmt]
  fmt --> validate[terraform validate]
  validate --> plan[terraform plan]
  plan --> review{Review Plan}
  review -- Approved --> apply[terraform apply]
  review -- Not Approved --> edit[Edit Configuration]
  edit --> fmt
  apply --> state[Update Terraform State]
  state --> output[Review Outputs / ZStack Console]
  output --> destroy{Clean Up Example Resources?}
  destroy -- Yes --> tfDestroy[terraform destroy]
  destroy -- No --> keep[Keep Resources Managed]
```

## Provider Authentication Configuration

```mermaid
flowchart LR
  subgraph inputs[Authentication Inputs]
    hcl[HCL provider block]
    env[ZSTACK_* Environment Variables]
    secret[CI/CD Secret Store]
  end

  secret --> env
  hcl --> provider[ZStack Provider]
  env --> provider

  provider --> accessKey{Authentication Method}
  accessKey --> ak[AccessKey Recommended]
  accessKey --> account[Account/Password Compatible]

  ak --> api[ZStack API Client]
  account --> api
```

## VM + L3 + Security Group + EIP

```mermaid
flowchart TB
  tf[Terraform] --> image[data.zstack_images]
  tf --> offering[data.zstack_instance_offerings]
  tf --> l3[data.zstack_l3networks]

  image --> vm[zstack_instance]
  offering --> vm
  l3 --> nic[VM NIC]
  vm --> nic

  sg[zstack_networking_secgroup] --> rule[zstack_networking_secgroup_rule]
  sg --> attach[zstack_networking_secgroup_attachment]
  nic --> attach

  publicL3[Public L3 Network] --> vip[zstack_vip]
  vip --> eip[zstack_eip]
  nic --> eip

  user[External Access] --> eip
  eip --> nic
```

## Load Balancer Web Scenario

```mermaid
flowchart TB
  public[Public L3 Network] --> vip[zstack_vip]
  vip --> lb[zstack_load_balancer]
  lb --> listener[zstack_load_balancer_listener]
  lb --> group[zstack_lb_server_group]

  listener --> group
  group --> vm1[Backend VM 1]
  group --> vm2[Backend VM 2]
  group --> vmn[Backend VM N]

  client[Client] --> vip
```

## VPC Routing Scenario

```mermaid
flowchart TB
  l2[L2 Network] --> vpc[zstack_vpc]
  vr[Virtual Router] --> vpc
  vpc --> subnet[Subnet CIDR]

  table[zstack_vrouter_route_table] --> entry[zstack_vrouter_route_entry]
  entry --> dest[Destination CIDR]
  entry --> target[Route Target]

  workload[Private Workloads] --> subnet
  subnet --> vr
  vr --> table
```
