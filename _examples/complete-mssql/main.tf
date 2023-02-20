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

module "subnets" {
  source  = "clouddrove/subnet/aws"
  version = "1.3.0"

  name        = "subnets"
  environment = "test"
  label_order = ["environment", "name"]

  availability_zones = ["ap-south-1a", "ap-south-1b"]
  vpc_id             = module.vpc.vpc_id
  type               = "private"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
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
  allowed_ports = [1433]
}


module "sqlserver" {
  source = "../../"

  name        = "sg"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name"]

  engine            = "sqlserver-ee"
  engine_version    = "15.00.4153.1.v1"
  instance_class    = "db.t3.small"
  allocated_storage = 50
  timezone          = "GMT Standard Time"

  # kms_key_id        = "arm:aws:kms:<region>:<accound id>:key/<kms key id>"

  # DB Details
  database_name = ""
  username      = "admin"
  password      = "esfsgcGdfawAhdxtfjm!"
  port          = "1433"

  vpc_security_group_ids = [module.security_group.security_group_ids]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  multi_az           = false


  # disable backups to create DB faster
  backup_retention_period = 0

  # enabled_cloudwatch_logs_exports = ["audit", "general"]

  # DB subnet group
  subnet_ids          = module.subnets.private_subnet_id
  publicly_accessible = false

  # DB parameter group
  family = "sqlserver-ee-15.0"

  # DB option group
  major_engine_version = "15.00"
}
