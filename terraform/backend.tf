terraform {
  backend "s3" {
    bucket = "devopschallenge.tfstate-bucket"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}