provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "0.15.0"

  name        = "vpc"
  environment = "test"
  label_order = ["environment", "name"]

  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source  = "clouddrove/subnet/aws"
  version = "0.15.0"

  name        = "subnets"
  environment = "test"
  label_order = ["environment", "name"]

  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
  ipv6_cidr_block    = module.vpc.ipv6_cidr_block
}

module "security_group" {
  source  = "clouddrove/security-group/aws"
  version = "0.15.0"

  name          = "security-group"
  environment   = "test"
  protocol      = "tcp"
  label_order   = ["environment", "name"]
  vpc_id        = module.vpc.vpc_id
  allowed_ip    = ["0.0.0.0/0"]
  allowed_ports = [3306]
}


module "mysql" {
  source = "../../"

  name        = "sg"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name"]

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.small"
  allocated_storage = 5

  # kms_key_id        = "arm:aws:kms:<region>:<accound id>:key/<kms key id>"

  # DB Details
  database_name = "test"
  username      = "user"
  password      = "esfsgcGdfawAhdxtfjm!"
  port          = "3306"

  vpc_security_group_ids = [module.security_group.security_group_ids]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  multi_az           = false


  # disable backups to create DB faster
  backup_retention_period = 0

  enabled_cloudwatch_logs_exports = ["audit", "general"]

  # DB subnet group
  subnet_ids          = module.subnets.public_subnet_id
  publicly_accessible = true

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion

  # Database Deletion Protection
  deletion_protection = false


  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
