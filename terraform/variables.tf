variable "account_id" {
  default = "836668077738"
}

variable "project_name" {
  default = "devopschallenge"
}

variable "elb_account_id" {
  default     = "156460612806"
  description = "A region specific Elastic Load Balancing account ID. The default is set for eu-west-1."
}

variable "region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}