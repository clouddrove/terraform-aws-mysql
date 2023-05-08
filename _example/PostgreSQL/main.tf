provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "1.3.0"

  name        = "vpc"
  environment = "test"
  label_order = ["environment", "name"]

  cidr_block = "10.0.0.0/16"
}

module "private_subnets" {
  source  = "clouddrove/subnet/aws"
  version = "1.3.0"

  name        = "subnets"
  environment = "test"
  label_order = ["name", "environment"]

  nat_gateway_enabled = true

  availability_zones              = ["ap-south-1a", "ap-south-1b"]
  vpc_id                          = module.vpc.vpc_id
  type                            = "public-private"
  igw_id                          = module.vpc.igw_id
  cidr_block                      = module.vpc.vpc_cidr_block
  ipv6_cidr_block                 = module.vpc.ipv6_cidr_block
  assign_ipv6_address_on_creation = false
}


module "security_group" {
  source  = "clouddrove/security-group/aws"
  version = "1.3.0"

  name          = "security-group"
  environment   = "test"
  protocol      = "tcp"
  label_order   = ["environment", "name"]
  vpc_id        = module.vpc.vpc_id
  allowed_ip    = ["0.0.0.0/0"]
  allowed_ports = [5432]
}

module "postgresql" {
  source = "../../"

  name        = "sg"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name"]

  engine            = "postgres"
  engine_version    = "14.1"
  instance_class    = "db.t3.medium"
  allocated_storage = 50
  storage_encrypted = true
  # kms_key_id        = "arm:aws:kms:<region>:<accound id>:key/<kms key id>"
  family = "postgres14"
  # DB Details
  database_name = "test"
  username      = "dbname"
  password      = "esfsgcGdfawAhdxtfjm!"
  port          = "5432"

  vpc_security_group_ids = [module.security_group.security_group_ids]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  multi_az           = false


  # disable backups to create DB faster
  backup_retention_period = 0

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # DB subnet group
  subnet_ids          = module.private_subnets.public_subnet_id
  publicly_accessible = true

  # DB option group
  major_engine_version = "14"

  # Snapshot name upon DB deletion

  # Database Deletion Protection
  deletion_protection = false

}
