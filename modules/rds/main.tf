resource "aws_db_instance" "this" {
 allocated_storage    = 20                    # minimum for MySQL
 engine               = "mysql"
 engine_version       = "8.0"
 instance_class       = var.instance_class    # e.g., db.t3.micro
 name                 = var.db_name           # database name
 username             = var.db_username       # admin username
 password             = var.db_password       # use SSM for production
 parameter_group_name = "default.mysql8.0"
 db_subnet_group_name = aws_db_subnet_group.this.name
 db_username            = data.aws_ssm_parameter.db_username.value
 db_password            = data.aws_ssm_parameter.db_password.value
 vpc_security_group_ids = [var.rds_sg_id]
 publicly_accessible  = var.publicly_accessible
 skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "this" {
 name       = "${var.project}-db-subnet-group"
 subnet_ids = var.private_subnet_ids
 tags = {
   Name = "${var.project}-db-subnet-group"
 }
}
