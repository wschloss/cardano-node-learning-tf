resource "aws_security_group" "cardano_node_ssh_and_tcp" {
  name        = "cardano_node_ssh_and_tcp"
  description = "Allows ssh access and TCP to the listening port for the cardano node"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.security_group_allowed_ingress_cidrs}"
  }

  ingress {
    from_port   = "${var.cardano_node_tcp_port}"
    to_port     = "${var.cardano_node_tcp_port}"
    protocol    = "tcp"
    cidr_blocks = "${var.security_group_allowed_ingress_cidrs}"
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}