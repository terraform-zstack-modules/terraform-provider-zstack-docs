# Create VM

Creating a VM is the most common starting scenario. Minimal dependencies include:

- Image UUID.
- L3 network UUID.
- Instance offering UUID, or direct `cpu_num` plus `memory_size`.
- Optional: root disk, static IP, multiple NICs, host/cluster/zone placement, and
  user data.

## Recommended Workflow

1. Query image, L3 network, and instance offering by name or UUID.
2. Organize VM input parameters in `locals`.
3. Use `zstack_instance` to create one VM.
4. Output VM UUID, name, and IP address for later troubleshooting.

## Network Configuration

New configurations should use `network_interfaces`:

```hcl
resource "zstack_instance" "vm" {
  name                   = var.vm_name
  image_uuid             = data.zstack_images.image.images[0].uuid
  instance_offering_uuid = data.zstack_instance_offerings.offering.instance_offers[0].uuid

  network_interfaces = [
    {
      l3_network_uuid = data.zstack_l3networks.network.l3networks[0].uuid
      default_l3      = true
      static_ip       = var.static_ip
    }
  ]
}
```

`l3_network_uuid` is the required L3 network binding for the NIC. `default_l3`
and `static_ip` are optional fields. Single-NIC scenarios usually can omit
`default_l3`; set `static_ip` only when a fixed IP is required. When `static_ip`
is omitted, ZStack allocates the address automatically. If it is passed through
a variable as in the example, use `default = null` so Terraform treats it as
unset.

Do not recommend old `l3_network_uuids` for new examples.

## Multiple VMs

For multiple VMs, prefer `for_each` and use VM names as stable keys. This avoids
unrelated VM replacement when adding or removing one VM later.

## Initialization Scripts

Advanced scenarios often need initialization scripts after VM creation. Related
resources:

| Terraform object | Type | Purpose |
|---|---|---|
| `zstack_ssh_key_pair` | resource | Create an SSH key pair for VM login or initialization script execution. |
| `zstack_instance_scripts` | resource | Create an instance script definition containing script content and type. |
| `zstack_instance_scripts_execution` | resource | Create a script execution record and apply the script to a target VM. |

Initialization scripts are suitable for package installation, guest agent
configuration, and baseline configuration. Parameterize script content and
timeout, and do not embed sensitive information in script text.

## Related Examples

- [examples/common/03-create-vm](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/03-create-vm)
- [examples/common/04-create-10-vms](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/04-create-10-vms)
- [examples/common/13-vm-init-scripts](https://github.com/terraform-zstack-modules/terraform-provider-zstack-docs/tree/main/examples/common/13-vm-init-scripts)
