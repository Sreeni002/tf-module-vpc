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

  tags = var.tags
  env = var.env
}