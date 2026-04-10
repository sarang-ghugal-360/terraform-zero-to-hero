resource "aws_vpc" "check" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_name
    }
  
}