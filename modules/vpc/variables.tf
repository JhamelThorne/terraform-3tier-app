variable "vpc_cidr" {

  description = "CIDR block for the VPC"

  type        = string

}

variable "public_subnet_cidrs" {

  description = "List of public subnet CIDR blocks"

  type        = list(string)

}

variable "private_subnet_cidrs" {

  description = "List of private subnet CIDR blocks"

  type        = list(string)

}

variable "availability_zones" {

  description = "List of availability zones"

  type        = list(string)

}

variable "project" {

  description = "Name tag for the resources"

  type        = string

} 
