output "node_public_ips" {
  value = "${join(",", aws_instance.node.*.public_ip)}"
}
