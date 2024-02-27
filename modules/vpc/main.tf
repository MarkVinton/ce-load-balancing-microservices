resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-igw"
    ManagedBy = "Terraform"
  }
}
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-public"
    ManagedBy = "Terraform"
  }
}