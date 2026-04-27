resource "aws_db_instance" "this" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  username          = var.username
  password          = var.password

  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name   = var.subnet_group
}