module "vpc" {
  source = "./modules/aws_vpc"

  environment             = "development"
  region                  = "${var.region}"
  vpc_cidr                = "10.0.0.0/16"
  name                    = "aws-kubernetes"
  map_public_ip_on_launch = true
  public_subnets          = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets         = ["10.0.10.0/24", "10.0.20.0/24"]
  enable_nat_gateway      = true

  #multi_nat_gateway       = true
}
