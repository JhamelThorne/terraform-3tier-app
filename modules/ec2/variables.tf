variable "iam_instance_profile" {
 description = "IAM instance profile to attach to EC2"
 type        = string
}

variable "ami_id" {
 description = "AMI ID for EC2 instance"
 type        = string
}
variable "instance_type" {
 description = "EC2 instance type"
 type        = string
}
variable "subnet_id" {
 description = "Subnet ID for EC2 instance"
 type        = string
}
variable "sg_id" {
 description = "Security Group ID"
 type        = string
}
variable "project" {
 description = "Project tag"
 type        = string
}
