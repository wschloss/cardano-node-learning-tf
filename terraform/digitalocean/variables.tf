variable "do_access_token_file" {
  type    = "string"
  default = "~/.digitalocean/credentials"
}

variable "node_droplet_size" {
  type    = "string"
  default = "s-1vcpu-1gb"
}

variable "image" {
  type    = "string"
  default = "ubuntu-18-04-x64"
}

variable "region" {
  type    = "string"
  default = "sfo2"
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
  default = "root"
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
