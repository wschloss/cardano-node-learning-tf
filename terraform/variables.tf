variable "cardano_node_instance_type" {
  default = "t2.micro"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-0b69ea66ff7391e80"
  }
}

variable "security_group_allowed_ingress_cidrs" {
  default = ["73.153.8.165/32"]
}

variable "ssh_settings" {
  type = "map"
  default = {
    "public_key_path"  = "~/.ssh/id_rsa.pub"
    "private_key_path" = "~/.ssh/id_rsa"
    "user"             = "ec2-user"
  }
}

variable "cardano_node_tcp_port" {
  default = "3101"
}

variable "cardano_node_docker_image" {
  default = "wcschlosser/cardano-node:latest"
}