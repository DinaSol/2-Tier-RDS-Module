#  creating a security group that allows DB-RDS traffic to get into the instance

# the security group of DB-RDS instance
resource "aws_security_group" "sg-2" {
  name        = "dina-security-group2"
  description = "Allow RDS traffic"
  vpc_id = data.aws_vpc.vpc.id
   
#  allow RDS inbound traffic
  ingress {
    description      = "RDS"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    # cidr_blocks = ["0.0.0.0/0"]

  }

#  allow all outbound traffic from the ec2 instance
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  tags = {
    Name = "allow_RDS"
  }
}

# creating the group of subnets that I want th DB-instance be in
resource "aws_db_subnet_group" "sub-gr" {
  name       = "dina-sub-group"
  
  # adding the variables of the private-subnet-1 & private-subnet-2
  subnet_ids = [var.rds-sub-id-1, var.rds-sub-id-2]
  tags       = {
    Name     = "dina-subnet-group"
  }
}

# creating the Mysql-DB-RDS instance
resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_name                = var.db-name
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = var.db-username
  password               = var.db-password
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = "dina-sub-group"
  multi_az               = true
  port = 3306
  vpc_security_group_ids = [aws_security_group.sg-2.id]
}