terraform {
  required_version = ">= 1.5"

  required_providers {
    zstack = {
      source  = "ZStack-Robot/zstack"
      version = "1.1.3"
    }
  }
}

provider "zstack" {
  host              = var.zstack_host
  port              = var.zstack_port
  access_key_id     = var.zstack_access_key_id
  access_key_secret = var.zstack_access_key_secret
}

import {
  to = zstack_instance.vm_01
  id = var.vm_01.uuid
}

import {
  to = zstack_instance.vm_02
  id = var.vm_02.uuid
}

resource "zstack_instance" "vm_01" {
  name        = var.vm_01.name
  description = var.vm_01.description
  image_uuid  = var.vm_01.image_uuid

  cpu_num     = var.vm_01.cpu_num
  memory_size = var.vm_01.memory_size

  network_interfaces = [
    {
      l3_network_uuid = var.vm_01.l3_network_uuid
      default_l3      = true
      static_ip       = var.vm_01.static_ip
    }
  ]
}

resource "zstack_instance" "vm_02" {
  name        = var.vm_02.name
  description = var.vm_02.description
  image_uuid  = var.vm_02.image_uuid

  cpu_num     = var.vm_02.cpu_num
  memory_size = var.vm_02.memory_size

  network_interfaces = [
    {
      l3_network_uuid = var.vm_02.l3_network_uuid
      default_l3      = true
      static_ip       = var.vm_02.static_ip
    }
  ]
}
