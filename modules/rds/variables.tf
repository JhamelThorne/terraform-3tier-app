variable "instance_class" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {

  sensitive = true
}
variable "rds_sg_id" {}

variable "private_subnet_ids" {

  type = list(string)
}
variable "project" {}

variable "publicly_accessible" {

  type    = bool

  default = false
} 
