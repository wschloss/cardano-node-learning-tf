variable "node_instance_type" {
  type = "string"
}

variable "ami" {
  type = "string"
}

variable "ingress_cidrs" {
  type = "list"
}

variable "ssh_public_key_path" {
  type = "string"
}

variable "ssh_private_key_path" {
  type = "string"
}

variable "ssh_user" {
  type = "string"
}

variable "node_tcp_port" {
  type = "string"
}

variable "node_docker_image" {
  type = "string"
}

variable "node_config" {
  type = "string"
}

variable "genesis_block_hash" {
  type = "string"
}