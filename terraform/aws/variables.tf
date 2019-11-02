variable "node_instance_type" {
  type    = "string"
  default = "t2.micro"
}

variable "ami" {
  type    = "string"
  default = "ami-0b69ea66ff7391e80"
}

variable "ingress_cidrs" {
  type    = "list"
  default = ["73.153.8.165/32"]
}

variable "ssh_public_key_path" {
  type    = "string"
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  type    = "string"
  default = "~/.ssh/id_rsa"
}

variable "ssh_user" {
  type    = "string"
  default = "ec2-user"
}

variable "node_storage_size_gb" {
  type    = "string"
  default = "4"
}

variable "node_tcp_port" {
  type    = "string"
  default = "3101"
}

variable "node_docker_image" {
  type    = "string"
  default = "wcschlosser/cardano-node:latest"
}

variable "node_config" {
  type    = "string"
  default = "node-config.yaml"
}

variable "genesis_block_hash" {
  type    = "string"
  default = "adbdd5ede31637f6c9bad5c271eec0bc3d0cb9efb86a5b913bb55cba549d0770"
}