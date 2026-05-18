# User Manual

The user manual explains the customer-facing workflows for ZStack provider
`1.1.3`. It is not a copy of the provider reference. It focuses on how to use
resources safely in real delivery scenarios.

Recommended reading order:

1. Install Terraform and confirm the runner can reach the ZStack management
   node.
2. Initialize the provider through the public Registry, offline mirror, or
   provider development configuration as appropriate.
3. Understand Terraform workflow, concept mapping, and provider execution model.
4. Configure authentication and query existing resources with data sources.
5. Create a VM and attach networking, security group, volume, and image inputs.
6. Add production scenarios such as EIP, load balancer, VPC, scripts, IAM, and
   monitoring.
7. Use import and migration guidance before bringing existing resources under
   Terraform management.
8. Read HCL style, diagnostics, and production guidance before production apply.
