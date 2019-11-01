output "cardano_node_public_ip" {
  value = "${aws_instance.cardano_node.public_ip}"
}
