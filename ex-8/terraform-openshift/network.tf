# Define private network
resource "openstack_networking_network_v2" "private-net" {
  name = "private-net"
  region	= "Ulm"
}

# Define subnet with IP range in private network
resource "openstack_networking_subnet_v2" "private-net-sub" {
  network_id = "${openstack_networking_network_v2.private-net.id}"
  cidr       = "192.168.5.0/24"
  region	= "Ulm"
}

# Create private router with link to external network
resource "openstack_networking_router_v2" "private-router" {
  name = "private-router"
  region	= "Ulm"
  #Network Id of public network for floating ips
  external_gateway = "ef7b2ca9-1d17-4381-87ae-2ef01d40bb1e"
}

# Add interface to private subnet to private router
resource "openstack_networking_router_interface_v2" "private-router-subnet" {
  router_id = "${openstack_networking_router_v2.private-router.id}"
  subnet_id = "${openstack_networking_subnet_v2.private-net-sub.id}"
  region = "Ulm"  
}
