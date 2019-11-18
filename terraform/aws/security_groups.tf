resource "aws_security_group" "node_ssh_and_tcp" {
  name        = "cardano_node_ssh_and_tcp"
  description = "Allows ssh access and TCP to the listening port for the cardano node"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.trusted_ingress_cidrs}"
  }

  ingress {
    from_port   = "${var.node_rest_port}"
    to_port     = "${var.node_rest_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.node_grpc_port}"
    to_port     = "${var.node_grpc_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}