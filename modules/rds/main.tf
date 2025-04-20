resource "aws_db_instance" "this" {
  allocated_storage    = 20            # minimum for MySQL
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class  # e.g., db.t3.micro
  identifier           = var.db_name    # database name
  username             = var.db_username  # admin username
  password             = var.db_password  # use SSM for production
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible  = var.publicly_accessible
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-subnet-group"  # Simplified name
  subnet_ids = var.private_subnet_ids
  
  tags = {
    Name = "${var.project}-db-subnet-group"
  }
}
