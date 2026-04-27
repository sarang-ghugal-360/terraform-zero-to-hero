variable "region" {}
variable "project_name" {}

variable "vpc_cidr" {}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "azs" { type = list(string) }

variable "ami" {}
variable "instance_type" {}

variable "db_username" {}
variable "db_password" {}