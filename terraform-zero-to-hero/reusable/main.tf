resource "aws_instance" "check" {
  
  ami = var.ami
  instance_type = var.type
  tags = {
    Name = var.name
  }
}