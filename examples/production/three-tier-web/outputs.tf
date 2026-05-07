output "web_vms" {
  description = "Web VM UUIDs and primary IP addresses."
  value = {
    for name, vm in zstack_instance.web : name => {
      uuid = vm.uuid
      ip   = vm.vm_nics[0].ip
    }
  }
}

output "app_vms" {
  description = "Application VM UUIDs and primary IP addresses."
  value = {
    for name, vm in zstack_instance.app : name => {
      uuid = vm.uuid
      ip   = vm.vm_nics[0].ip
    }
  }
}

output "app_data_volumes" {
  description = "Application data volume UUIDs."
  value = {
    for name, volume in zstack_volume.app_data : name => volume.uuid
  }
}

output "web_entry" {
  description = "Public web entry resources."
  value = {
    vip_uuid           = zstack_vip.web.uuid
    load_balancer_uuid = zstack_load_balancer.web.uuid
    listener_uuid      = zstack_load_balancer_listener.http.uuid
    server_group_uuid  = zstack_lb_server_group.web.uuid
  }
}

output "security_groups" {
  description = "Security group UUIDs."
  value = {
    web = zstack_networking_secgroup.web.uuid
    app = zstack_networking_secgroup.app.uuid
  }
}

output "tags" {
  description = "Tag UUIDs applied to the reference deployment."
  value = {
    environment = zstack_tag.environment.uuid
    application = zstack_tag.application.uuid
    owner       = zstack_tag.owner.uuid
  }
}
