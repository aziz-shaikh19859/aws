provider "aws" {
  region = "eu-west-1"
}

resource "aws_db_instance" "rds" {
  allocated_storage    = var.main_allocated_storage
  engine               = var.main_db_engine
  engine_version       = var.main_db_version
  instance_class       = var.main_db_instance_class
  username             = var.main_db_username
  password             = "testtest"
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot = true
  multi_az             = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
   identifier           = "jenkinsterraform"
  backup_retention_period = 7
}

resource "aws_security_group" "rds_sg" {
  name        = var.sg_name
  vpc_id      = var.sg_vpc_id

  ingress {
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_protocol
    cidr_blocks = var.cidr
  }
}

variable "main_allocated_storage"{
type = number
default = "20"
}

variable "main_db_engine"{
type = string
default = "MySQL"
}

variable "main_db_instance_class"{
type = string
default = "db.t2.micro"

}

variable "main_db_username" {
type = string  
default = "admin"
}

variable "parameter_group_name" {
    type = string 
default = ""
}

variable "password" {
type = string 
default ="password" 
}

variable "main_db_version" {
    type = string
  default = "8.0.35"
}

variable "replica_instance_class" {
    type = string
    default = "db.t2.micro"
  
}

variable "replica_count" {
  type = number
  default = 1
}

variable "rds_replica_azs" {
  type = list(string)
  default = [""]
}
variable "sg_vpc_id" {
    type = string
    default = "vpc-0d0b526a37fe84274"
  
}
variable "sg_ingress_from_port" {
    type = number
    default = 3306
  
}
variable "sg_ingress_to_port" {
    type = number
    default = 3306
  
}

variable "cidr"{
type = list(string)
default = [ "0.0.0.0/0" ]
}

variable "sg_protocol" {
    type = string
    default = "tcp"
}
variable "sg_name" {
  type = string
  default = ""
}

