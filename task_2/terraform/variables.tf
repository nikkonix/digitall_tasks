variable "aws_region" { default = "eu-north-1"}
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "web_instance_count" { default = 2 }
variable "instance_type" { default = "t3.micro" }
variable "key_name" { default = "test-key" }
variable "db_name" { default = "taks2_db" }
variable "db_user" { default = "task2_dbuser" }
variable "db_password" { default = "task2_dbpassword123!"}

