output "node_public_ip" {
  value = "${digitalocean_droplet.node.ipv4_address}"
}