resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.env}- vpc"})
}

module "subnets" {
  source = "./subnets"

  for_each = var.subnets
  cidr_block = each.value["cidr_block"]
  vpc_id = aws_vpc.main.id
  name = each.value["name"]
  azs = each.value["azs"]

  tags = var.tags
  env = var.env
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { Name = "${var.env}- igw"})
}