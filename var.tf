variable "vpc" {}
data "aws_vpc" "vpc" {
  id = var.vpc
}



variable "db-name" { }
variable "db-username" {default = "dina"}
variable "db-password" {default = "dina123456"}



# get private-sub-id-1 from subnets-module 
variable "rds-sub-id-1" {}

# get private-sub-id-2 from subnets-module 
variable "rds-sub-id-2" {}