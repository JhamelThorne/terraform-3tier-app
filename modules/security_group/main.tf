locals {
  # Check if my_ip already contains a subnet mask, if not add /32
  my_ip_cidr = length(regexall("/", var.my_ip)) > 0 ? var.my_ip : "${var.my_ip}/32"
}

resource "aws_security_group" "app_sg" {
  name        = "${var.project}-sg"
  description = "Allow inbound HTTP, SSH, and DB access"

  vpc_id      = var.vpc_id
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }
  ingress {
    description = "MySQL from EC2 subnet"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.ec2_subnet_cidrs
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project}-sg"
  }

} 
