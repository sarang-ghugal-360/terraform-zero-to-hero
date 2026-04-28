provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "devops_server" {
ami           = "ami-0f5ee92e2d63afc18" # Amazon Linux 2 (Mumbai)
instance_type = "t2.micro"

# Security group inline (allow HTTP + SSH)

vpc_security_group_ids = [aws_security_group.devops_sg.id]

user_data = <<-EOF
#!/bin/bash
yum update -y
yum install docker -y
systemctl start docker
systemctl enable docker

```
          # Run sample nginx container
          docker run -d -p 80:80 nginx
          EOF

tags = {
Name = "devops-practice-server"
}
}

resource "aws_security_group" "devops_sg" {
name = "devops-sg"

ingress {
from_port   = 80
to_port     = 80
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
