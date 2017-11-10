############
## VPC
############
resource "aws_vpc" "self" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    builtWith         = "terraform"
    KubernetesCluster = "${var.name}"
    Name              = "${var.name}"
    visibility        = "private,public"
    environment       = "${var.environment}"
  }
}

# resource "null_resource" "dummy_dependency" {
#   depends_on = [
#     "aws_vpc.environment",
#   ]
# }

