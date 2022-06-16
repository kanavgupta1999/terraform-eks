/*==== The VPC ======*/
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.name}-vpc"
  }
}
/* Internet gateway attach to vpc */
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.name}-igw"
  }
}
/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = var.public_subnets_cidr
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.name}-public-subnet"
  }
}
/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = var.private_subnets_cidr
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.name}-private-subnet"
  }
}
/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.name}-private-route-table"
  }
}
/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.name}-public-route-table"
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = var.public_cidr_block
  gateway_id             = "${aws_internet_gateway.ig.id}"
}
resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = var.private_cidr_block
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}
/* Route table associations */
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private.id}"
}
/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}
/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Environment = "${var.name}-nat-gateway"
  }
}