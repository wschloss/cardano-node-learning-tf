provider "aws" {
  version = "2.34.0"
  profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "com.cardano.test.terraform.state"
    key    = "test/cardano-terraform-state"
    region = "us-east-1"
  }
}
