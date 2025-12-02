# ------------------------------
# VPC & Subnets
# ------------------------------

# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Public Subnets für EC2
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

# Private Subnets für RDS
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}


# ------------------------------
# Security Group
# ------------------------------
resource "aws_security_group" "web_sg" {
  name        = "aws-grocery-sg"
  description = "Security Group for AWS Grocery App"

  # Ingress Rules
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

  # Egress Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AWS-Grocery-SG"
  }
}

# ------------------------------
# EC2 Instance
# ------------------------------
resource "aws_instance" "grocery_ec2" {
  ami                    = "ami-03b7a7ce915b46b75" # Ubuntu 22.04 Frankfurt
  instance_type          = "t2.micro"
  key_name               = "test"
  subnet_id              = data.aws_subnets.public.ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "AWS-Grocery-Server"
  }
}

# ------------------------------
# RDS Subnet Group
# ------------------------------
resource "aws_db_subnet_group" "default" {
  name       = "grocery-subnet-group"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name = "Grocery DB subnet group"
  }
}

# ------------------------------
# RDS MySQL Instance
# ------------------------------
resource "aws_db_instance" "grocery_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "grocerydb"
  username             = "admin"
  password             = var.db_password
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.name

  tags = {
    Name = "Grocery-RDS"
  }
}
