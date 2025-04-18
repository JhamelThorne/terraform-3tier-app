output "public_subnet_cidrs" {
 value = var.public_subnet_cidrs
 description = "List of public subnet CIDRs"
}
output "private_subnet_cidrs" {
 value = var.private_subnet_cidrs
 description = "List of private subnet CIDRs"
}
output "vpc_id" {
 value = aws_vpc.main.id
 description = "VPC ID"
}
