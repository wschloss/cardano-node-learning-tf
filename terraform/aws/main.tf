provider "aws" {
  version = "2.34.0"
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}