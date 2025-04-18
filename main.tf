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
  vpc = true
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

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
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


module "rds" {
 source                 = "./modules/rds"
 instance_class         = "db.t3.micro"
 db_name                = "appdb"
 db_username            = data.aws_ssm_parameter.db_username.value
 db_password            = data.aws_ssm_parameter.db_password.value
 rds_sg_id              = module.security_group.rds_sg_id
 private_subnet_ids     = module.vpc.private_subnet_ids
 project                = var.project
 publicly_accessible    = true
}

module "ec2" {
 source               = "./modules/ec2"
 ami_id               = "ami-xxxx"
 instance_type        = "t2.micro"
 subnet_id            = module.vpc.public_subnet_ids[0]
 sg_id                = module.security_group.sg_id
 project              = var.project
 iam_instance_profile = module.ec2.ec2_ssm_profile_name
}
module "security_group" {
  source            = "./modules/security_group"
  vpc_id            = module.vpc.vpc_id
  my_ip             = "98.84.xx.xx/32"  # Replace with your IP
  project           = var.project
  ec2_subnet_cidrs  = module.vpc.public_subnet_cidrs
} 
module "vpc" {
 source = "./modules/vpc"
 vpc_cidr = var.vpc_cidr
 public_subnet_cidrs = var.public_subnet_cidrs
 private_subnet_cidrs = var.private_subnet_cidrs
 availability_zones = var.availability_zones
 project = var.project
}

data "aws_ssm_parameter" "db_username" {
 name = "/project2/db_username"
}
data "aws_ssm_parameter" "db_password" {
 name = "/project2/db_password"
}
