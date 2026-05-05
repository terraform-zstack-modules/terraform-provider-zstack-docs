data "zstack_images" "image" {
  name = var.image_name
}

data "zstack_l3networks" "network" {
  name = var.l3_network_name
}

data "zstack_instance_offerings" "offering" {
  name = var.instance_offering_name
}

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
