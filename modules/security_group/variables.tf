variable "vpc_id" {
  type        = string
  description = "VPC ID to attach SG to"
}
variable "project" {
  type        = string
  description = "Project tag name"
}
variable "my_ip" {
  type        = string
  description = "Your public IP with CIDR mask (e.g., 98.84.x.x/32)"
}
variable "ec2_subnet_cidrs" {
  type        = list(string)
  description = "List of EC2 subnet CIDRs allowed to reach DB"
} 
