provider "digitalocean" {
  version = "1.10.0"
  token   = "${chomp(file(var.do_access_token_file))}"
}