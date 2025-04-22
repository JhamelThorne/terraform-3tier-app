resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.project}-nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project}-private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "private" {
 vpc_id = aws_vpc.main.id
 route {
   cidr_block     = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.nat.id
 }
 tags = {
   Name = "${var.project}-private-rt"
 }
}
resource "aws_route_table_association" "private" {
 count          = length(var.private_subnet_cidrs)
 subnet_id      = aws_subnet.private[count.index].id
 route_table_id = aws_route_table.private.id
}
