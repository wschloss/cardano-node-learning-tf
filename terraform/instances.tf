resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = "${file(var.ssh_settings["public_key_path"])}"
}

resource "aws_instance" "cardano_node" {
  key_name        = "${aws_key_pair.ssh_key.key_name}"
  ami             = "${var.amis[data.aws_region.current.name]}"
  instance_type   = "${var.cardano_node_instance_type}"
  security_groups = ["${aws_security_group.cardano_node_ssh_and_tcp.name}"]

  connection {
    type        = "ssh"
    user        = "${var.ssh_settings["user"]}"
    private_key = "${file(var.ssh_settings["private_key_path"])}"
    host        = "${self.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo docker run -d -p ${var.cardano_node_tcp_port}:${var.cardano_node_tcp_port} --name cardano-node ${var.cardano_node_docker_image}"
    ]
  }
}