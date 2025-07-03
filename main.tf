# To create a Ec2 instance you also need to create many other resources.

#keypair to connect to ec2

resource "aws_key_pair" "terra-key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}

#vpc for our ec2 insatnce

resource "aws_default_vpc" "terra-vpc-default" {

}

#security group for our ec2 instance 

resource "aws_security_group" "terra-sg" {
  vpc_id      = aws_default_vpc.terra-vpc-default.id
  name        = "terra-sg"
  description = "this is terraform created security group"
  tags = {
    name = "terra-sg"
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
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#our ec2 instance itself

resource "aws_instance" "terra-server" {
  # count = 3  # meta argument

  for_each = tomap({ # meta argument
    instance_1 = "t3.micro",
    instance_2 = "t3.micro"
  })

  depends_on = [aws_security_group.terra-sg, aws_default_vpc.terra-vpc-default]

  key_name        = aws_key_pair.terra-key.key_name
  security_groups = [aws_security_group.terra-sg.name]
  ami             = var.ec2_ami_id
  instance_type   = each.value

  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }

}