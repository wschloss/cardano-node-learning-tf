resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = "${file(var.ssh_public_key_path)}"
}

resource "aws_instance" "node" {
  key_name        = "${aws_key_pair.ssh_key.key_name}"
  ami             = "${var.ami}"
  instance_type   = "${var.node_instance_type}"
  security_groups = ["${aws_security_group.node_ssh_and_tcp.name}"]
  root_block_device {
    volume_size = "${var.node_storage_size_gb}"
  }

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    private_key = "${file(var.ssh_private_key_path)}"
    host        = "${self.public_ip}"
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
    command = "../generate_and_scp_node_configuration.sh ${var.ssh_private_key_path} ${var.ssh_user} ${aws_instance.node.public_ip} ${var.node_private_id} ${var.stake_pool_sig_key} ${var.stake_pool_vrf_key} ${var.stake_pool_node_id}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo docker run -d -p ${var.node_rest_port}:${var.node_rest_port} -p ${var.node_grpc_port}:${var.node_grpc_port} --name cardano-node -v /configuration:/configuration:ro -v /storage:/root/storage ${var.node_docker_image} /root/jormungandr --config /configuration/node-config.yaml --secret /configuration/node-secret.yaml --genesis-block-hash ${var.genesis_block_hash}"
    ]
  }
}