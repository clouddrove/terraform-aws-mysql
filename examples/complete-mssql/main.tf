####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = "ap-south-1"
}

####----------------------------------------------------------------------------------
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
####----------------------------------------------------------------------------------
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = "vpc"
  environment = "test"
  label_order = ["environment", "name"]
  cidr_block  = "10.0.0.0/16"
}

####----------------------------------------------------------------------------------
## A subnet is a range of IP addresses in your VPC.
####----------------------------------------------------------------------------------
module "subnets" {
  source  = "clouddrove/subnet/aws"
  version = "2.0.1"

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

####----------------------------------------------------------------------------------
## relational database management system.
####----------------------------------------------------------------------------------
module "sqlserver" {
  source = "../../"

  name        = "sqlserver"
  environment = "test"
  label_order = ["environment", "name"]

  engine            = "sqlserver-se"
  engine_version    = "15.00"
  instance_class    = "db.t3.large"
  engine_name       = "sqlserver-se"
  allocated_storage = 20
  timezone          = "GMT Standard Time"
  license_model     = "license-included"

  # DB Details
  db_name             = "mssql"
  username            = "admin"
  password            = "esfsgcGdfawAhdxtfjm!"
  port                = "1433"
  maintenance_window  = "Mon:00:00-Mon:03:00"
  backup_window       = "03:00-06:00"
  multi_az            = true
  deletion_protection = true

  ####----------------------------------------------------------------------------------
  ## Below A security group controls the traffic that is allowed to reach and leave the resources that it is associated with.
  ####----------------------------------------------------------------------------------
  vpc_id        = module.vpc.vpc_id
  allowed_ip    = [module.vpc.vpc_cidr_block]
  allowed_ports = [1433]

  # disable backups to create DB faster
  backup_retention_period = 7

  enabled_cloudwatch_logs_exports = ["error"]
  enabled_cloudwatch_log_group    = false

  # DB subnet group
  subnet_ids          = module.subnets.private_subnet_id
  publicly_accessible = false

  # DB parameter group
  family = "sqlserver-se-15.0"

  # DB option group
  major_engine_version = "15.00"

  ###ssm parameter
  ssm_parameter_endpoint_enabled = true
}
