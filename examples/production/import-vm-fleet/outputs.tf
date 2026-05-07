output "imported_vms" {
  description = "Imported VM UUIDs and primary IP addresses after refresh."
  value = {
    vm_01 = {
      uuid = zstack_instance.vm_01.uuid
      ip   = zstack_instance.vm_01.vm_nics[0].ip
    }
    vm_02 = {
      uuid = zstack_instance.vm_02.uuid
      ip   = zstack_instance.vm_02.vm_nics[0].ip
    }
  }
}
