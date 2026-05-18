# Create VM

Use `zstack_instance` to create VMs. New examples should use
`network_interfaces` instead of the older `l3_network_uuids` style.

## Single VM

The basic flow is:

1. Query the image, L3 network, and instance offering.
2. Create `zstack_instance`.
3. Attach the selected L3 network through `network_interfaces`.
4. Output VM identity and NIC information for troubleshooting.

In `network_interfaces`, `l3_network_uuid` is the required L3 network binding.
`default_l3` and `static_ip` are optional: single-NIC VMs usually do not need an
explicit `default_l3`, and `static_ip` should be set only when a fixed address is
required. Omit `static_ip` to let ZStack allocate the address; when passing it
through a variable as this example does, a `null` default lets Terraform treat
the argument as unset.

See [examples/common/03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm).

## Multiple VMs

Use `for_each` with stable keys for batch creation. Avoid `count` when deleting
or inserting an item could shift indexes.

See [examples/common/04-create-10-vms](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms).

## Initialization Scripts

Use SSH key and instance script resources for day-1 initialization.

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_ssh_key_pair` | resource | Create an SSH key pair for VM login or script execution workflows. |
| `zstack_instance_scripts` | resource | Create an instance script definition with script content and type. |
| `zstack_instance_scripts_execution` | resource | Create a script execution record that runs the script against a selected VM. |

Keep secrets out of script content and prefer external secret stores for
long-lived secrets.

See [examples/common/13-vm-init-scripts](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/13-vm-init-scripts).
