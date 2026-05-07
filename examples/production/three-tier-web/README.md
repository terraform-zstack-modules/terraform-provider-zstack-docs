# three-tier-web

Production reference infrastructure for a simple three-tier web application on
ZStack.

This example creates:

- web tier VMs
- application tier VMs
- application data volumes
- web and application security groups
- VIP, load balancer, listener, and server group
- standard environment, application, and owner tags

It does not deploy application code, configure databases, or wire load balancer
backend membership beyond creating the server group. Treat it as an
infrastructure reference and adapt it to the customer's runtime and release
pipeline.

Run `02-query-existing-resources` first, then narrow the image, network,
offering, and public L3 values in `terraform.tfvars`.
