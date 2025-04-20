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
