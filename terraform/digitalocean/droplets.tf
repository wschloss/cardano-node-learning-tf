resource "digitalocean_ssh_key" "ssh_key" {
  name       = "Cardano node key"
  public_key = "${file(var.ssh_public_key_path)}"
}

resource "digitalocean_droplet" "node" {
  name     = "cardano-node"
  image    = "${var.image}"
  region   = "${var.region}"
  size     = "${var.node_droplet_size}"
  ssh_keys = ["${digitalocean_ssh_key.ssh_key.fingerprint}"]
  monitoring = true

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    private_key = "${file(var.ssh_private_key_path)}"
    host        = "${self.ipv4_address}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /configuration",
      "sudo chmod a+rw /configuration",
      "sudo mkdir -p /storage",
      "sudo chmod a+rw /storage"
    ]
  }

  provisioner "local-exec" {
    command = "../generate_and_scp_node_configuration.sh ${var.ssh_private_key_path} ${var.ssh_user} ${digitalocean_droplet.node.ipv4_address} ${var.node_private_id} ${var.stake_pool_sig_key} ${var.stake_pool_vrf_key} ${var.stake_pool_node_id}"
  }

  provisioner "remote-exec" {
    inline = [
      "apt update -y",
      "apt upgrade -y",
      "apt install docker.io -y",
      "docker run -d -p ${var.node_rest_port}:${var.node_rest_port} -p ${var.node_grpc_port}:${var.node_grpc_port} --name cardano-node -v /configuration:/configuration:ro -v /storage:/root/storage ${var.node_docker_image} /root/jormungandr --config /configuration/node-config.yaml --secret /configuration/node-secret.yaml --genesis-block-hash ${var.genesis_block_hash}"
    ]
  }
}