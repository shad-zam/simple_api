module "vpc" {
  source = "./terraform_modules/aws-vpc"

  create_vpc      = true
  name            = "swisscom"
  cidr            = "192.168.0.0/23"
  public_subnets  = ["192.168.0.0/27", "192.168.0.32/27", "192.168.0.64/27"]
  private_subnets = ["192.168.0.96/27", "192.168.0.128/27", "192.168.0.160/27"]
  db_subnets      = ["192.168.0.192/27", "192.168.0.224/27", "192.168.1.0/27"]

}