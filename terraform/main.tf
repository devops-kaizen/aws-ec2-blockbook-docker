provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "deployer_1" {
  key_name   = "blockbook_docker_key"
  public_key = file("../auth/blockbook_docker_key.pub")
}

resource "aws_security_group" "blockbook_docker_sg" {
  name        = "blockbook_docker_sg"
  description = "Security group for Blockbook Docker"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Mainnet Ports
  ingress {
    from_port   = 8066
    to_port     = 8066
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 38366
    to_port     = 38366
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9066
    to_port     = 9066
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9166
    to_port     = 9166
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Testnet Ports
  ingress {
    from_port   = 18066
    to_port     = 18066
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 48366
    to_port     = 48366
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 19066
    to_port     = 19066
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 19166
    to_port     = 19166
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ICMP for Ping
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "blockbook_docker_server" {
  ami           = "ami-07c8c1b18ca66bb07"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer_1.key_name

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.blockbook_docker_sg.id]

  tags = {
    Name = "BlockbookDockerServer"
  }
}

output "blockbook_docker_instance_ip" {
  value = aws_instance.blockbook_docker_server.public_ip
}
