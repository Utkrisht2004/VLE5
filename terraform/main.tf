provider "aws" {
  region = "ap-south-1" # Mumbai Region
}

# 1. Security Group to allow Web and Management traffic
resource "aws_security_group" "vle5_sg" {
  name        = "bitedash-pipeline-sg"
  description = "Allow SSH, HTTP, and K8s NodePort"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NodePort range for Kubernetes (used to access the app)
  ingress {
    from_port   = 30000
    to_port     = 32767
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

# 2. The EC2 Instance (Must be t3.medium for Minikube)
resource "aws_instance" "devops_server" {
  ami           = "ami-0dee22c13ea7a9a67" # Ubuntu 24.04 LTS Mumbai
  instance_type = "t3.medium"             # 2 vCPU, 4GB RAM required for K8s
  key_name      = "BiteDash"              # Your existing key name
  vpc_security_group_ids = [aws_security_group.vle5_sg.id]

  tags = {
    Name = "BiteDash-Pipeline-Server"
  }
}

output "instance_ip" {
  value = aws_instance.devops_server.public_ip
}