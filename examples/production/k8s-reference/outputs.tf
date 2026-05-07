output "control_plane_nodes" {
  description = "Control-plane node UUIDs and primary IP addresses."
  value = {
    for name, vm in zstack_instance.control_plane : name => {
      uuid = vm.uuid
      ip   = vm.vm_nics[0].ip
    }
  }
}

output "worker_nodes" {
  description = "Worker node UUIDs and primary IP addresses."
  value = {
    for name, vm in zstack_instance.worker : name => {
      uuid = vm.uuid
      ip   = vm.vm_nics[0].ip
    }
  }
}

output "api_endpoint" {
  description = "Kubernetes API entry resources."
  value = {
    vip_uuid           = zstack_vip.api.uuid
    load_balancer_uuid = zstack_load_balancer.api.uuid
    listener_uuid      = zstack_load_balancer_listener.api.uuid
    server_group_uuid  = zstack_lb_server_group.api.uuid
  }
}

output "node_security_group_uuid" {
  description = "Security group UUID applied to Kubernetes nodes."
  value       = zstack_networking_secgroup.cluster.uuid
}

output "cluster_tag_uuid" {
  description = "Cluster tag UUID applied to Kubernetes nodes."
  value       = zstack_tag.cluster.uuid
}
