# Create VM

Use `zstack_instance` to create VMs. New examples should use
`network_interfaces` instead of the older `l3_network_uuids` style.

## Single VM

The basic flow is:

1. Query the image, L3 network, and instance offering.
2. Create `zstack_instance`.
3. Attach the selected L3 network through `network_interfaces`.
4. Output VM identity and NIC information for troubleshooting.

See `examples/common/03-create-vm`.

## Multiple VMs

Use `for_each` with stable keys for batch creation. Avoid `count` when deleting
or inserting an item could shift indexes.

See `examples/common/04-create-10-vms`.

## Initialization Scripts

Use SSH key and instance script resources for day-1 initialization. Keep secrets
out of script content and prefer external secret stores for long-lived secrets.

See `examples/common/13-vm-init-scripts`.
