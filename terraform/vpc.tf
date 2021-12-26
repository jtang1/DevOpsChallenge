module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  name            = "${var.project_name}_vpc"
  cidr            = var.vpc_cidr
  azs             = var.azs
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Terraform = "true"
  }
}