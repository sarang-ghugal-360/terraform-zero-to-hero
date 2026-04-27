resource "aws_instance" "sarang" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
      Name =var.name
    }
  
}