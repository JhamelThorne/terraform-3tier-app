resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "${var.project}-ssm-profile"
  role = aws_iam_role.ec2_parameter_store.name
}

resource "aws_iam_role" "ec2_parameter_store" {
  name = "${var.project}-ec2-parameter-store"  # Add project prefix for uniqueness
  # Rest of the configuration remains the same
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_instance" "my_instance" {
 ami                         = var.ami_id
 instance_type               = var.instance_type
 subnet_id                   = var.subnet_id  # Updated for better scalability
 vpc_security_group_ids      = [var.sg_id]
 associate_public_ip_address = true
 iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_profile.name
 user_data                   = file("${path.module}/user_data.sh")
 tags = {
   Name = "${var.project}-ec2"
 }
}
