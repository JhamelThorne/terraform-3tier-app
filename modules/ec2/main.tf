resource "aws_iam_instance_profile" "ssm_profile" {
 name = "${var.project}-ssm-profile"
 role = "ec2-parameter-store"
}
resource "aws_instance" "my_instance" {
 ami                         = var.ami_id
 instance_type               = var.instance_type
 subnet_id                   = var.subnet_id
 vpc_security_group_ids      = [var.sg_id]
 associate_public_ip_address = true
 iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
 user_data = file("${path.module}/user_data.sh")
 tags = {
   Name = "${var.project}-ec2"
 }
}
