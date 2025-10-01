locals {
  name          = "pgsql-new"
  environment   = "test"
  region        = "us-east-1"
  label_order   = ["name", "environment"]
} 

####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = local.region
}

####----------------------------------------------------------------------------------
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
####----------------------------------------------------------------------------------
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = "${local.name}-vpc"
  environment = local.environment
  label_order = local.label_order

  cidr_block = "10.0.0.0/16"
}

####----------------------------------------------------------------------------------
## A subnet is a range of IP addresses in your VPC.
####----------------------------------------------------------------------------------
module "private_subnets" {
  source ="clouddrove/subnet/aws"
  version = "2.0.1"

  name        = "${local.name}-subnets"
  environment = local.environment
  label_order = local.label_order

  nat_gateway_enabled = true

  availability_zones = ["${local.region}a", "${local.region}b"]
  vpc_id             = module.vpc.vpc_id
  type               = "public-private"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

####----------------------------------------------------------------------------------
## relational database management system.
####----------------------------------------------------------------------------------
module "postgresql" {
  source = "../../"

  name        = local.name
  environment = local.environment
  label_order = local.label_order

  engine            = "postgres"
  engine_version    = "17.6"
  instance_class    = "db.t3.medium"
  allocated_storage = 50
  engine_name       = "postgres"
  storage_encrypted = true
  family            = "postgres17"
  # DB Details
  db_name  = "test"
  username = "dbname"
  password = "esfsgcGdfawAhdxtfjm!"
  port     = "5432"

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  multi_az           = false

  ####----------------------------------------------------------------------------------
  ## Below A security group controls the traffic that is allowed to reach and leave the resources that it is associated with.
  ####----------------------------------------------------------------------------------
  vpc_id        = module.vpc.vpc_id
  allowed_ip    = [module.vpc.vpc_cidr_block]
  allowed_ports = [5432]

  # disable backups to create DB faster
  backup_retention_period = 7

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # disable creation of Read Replica
  enabled_read_replica = false

  # DB subnet group
  subnet_ids          = module.private_subnets.public_subnet_id
  publicly_accessible = true

  # DB option group
  major_engine_version = "17"

  # Database Deletion Protection
  deletion_protection = false

  ###ssm parameter
  ssm_parameter_endpoint_enabled = true

}
