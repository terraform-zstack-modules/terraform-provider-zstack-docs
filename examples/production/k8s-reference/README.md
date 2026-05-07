# k8s-reference

Production reference infrastructure for Kubernetes nodes on ZStack.

This example creates:

- control-plane VMs
- worker VMs
- node security group and core rules
- VIP, load balancer, listener, and server group for the Kubernetes API
- a cluster tag applied to all nodes

It does not install Kubernetes, generate kubeadm tokens, manage certificates,
configure CNI, or create storage classes. Use the outputs as inputs to a
separate kubeadm, Ansible, Cluster API, or GitOps workflow.

Use a hardened node image prepared for the customer's Kubernetes version and
confirm the API VIP/LB backend membership model before production apply.
