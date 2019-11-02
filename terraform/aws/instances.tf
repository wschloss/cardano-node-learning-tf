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
      "sudo chmod a+rw /configuration"
    ]
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.ssh_private_key_path} ../../config/${var.node_config} ${var.ssh_user}@${aws_instance.node.public_ip}:/configuration/${var.node_config}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo docker run -d -p ${var.node_tcp_port}:${var.node_tcp_port} --name cardano-node -v /configuration:/configuration:ro ${var.node_docker_image} /root/jormungandr --config /configuration/${var.node_config} --genesis-block-hash ${var.genesis_block_hash}"
    ]
  }
}