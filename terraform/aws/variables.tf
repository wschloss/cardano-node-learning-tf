variable "aws_profile" {
  type    = "string"
  default = "default"
}

variable "region" {
  type    = "string"
  default = "us-east-1"
}


variable "node_instance_type" {
  type    = "string"
  default = "t2.micro"
}

variable "ami" {
  type    = "string"
  default = "ami-0b69ea66ff7391e80"
}

variable "instance_count" {
  type    = "string"
  default = "1"
}


variable "trusted_ingress_cidrs" {
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
  default = "16"
}

variable "node_rest_port" {
  type    = "string"
  default = "3101"
}

variable "node_grpc_port" {
  type    = "string"
  default = "3000"
}

variable "node_docker_image" {
  type    = "string"
  default = "wcschlosser/cardano-node:latest"
}

variable "genesis_block_hash" {
  type    = "string"
  default = "adbdd5ede31637f6c9bad5c271eec0bc3d0cb9efb86a5b913bb55cba549d0770"
}

variable "node_private_id" {
  type    = "string"
  default = "~/.jormungandr/wallet/receiver_secret.key"
}

variable "stake_pool_sig_key" {
  type    = "string"
  default = "~/.jormungandr/stake_pool/stake_pool_kes.prv"
}

variable "stake_pool_vrf_key" {
  type    = "string"
  default = "~/.jormungandr/stake_pool/stake_pool_vrf.prv"
}

variable "stake_pool_node_id" {
  type    = "string"
  default = "~/.jormungandr/stake_pool/stake_pool.id"
}
