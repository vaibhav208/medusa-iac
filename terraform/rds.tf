resource "aws_db_subnet_group" "default" {
  name       = "medusa-db-subnet-group"
  subnet_ids = aws_subnet.public[*].id
  tags = {
    Name = "medusa-db-subnet-group"
  }
}

resource "aws_db_instance" "medusa" {
  identifier        = "medusa-db"
  allocated_storage = 20
  engine            = "postgres"
  engine_version    = "15.3"
  instance_class    = "db.t3.micro"
  name              = "medusadb"
  username          = "medusa"
  password          = "medusadb123"
  db_subnet_group_name = aws_db_subnet_group.default.name
  skip_final_snapshot = true
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  tags = {
    Name = "medusa-db"
  }
}

resource "aws_security_group" "rds" {
  name   = "medusa-rds-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
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