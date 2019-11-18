resource "digitalocean_firewall" "node_ssh_and_tcp" {
  name        = "cardano-node-ssh-and-tcp"
  droplet_ids = ["${digitalocean_droplet.node.id}"]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = "${var.trusted_ingress_cidrs}"
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "${var.node_rest_port}"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "${var.node_grpc_port}"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}