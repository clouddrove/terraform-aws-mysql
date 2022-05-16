
#Module      : label
#Description : This terraform module is designed to generate consistent label names and
#              tags for resources. You can use terraform-labels to implement a strict
#              naming convention.
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "0.15.0"

  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

locals {
  family                                = coalesce(var.family, join(local.family_separator, [var.engine, local.major_version_substring]))
  family_separator                      = local.is_mssql || local.is_oracle || local.is_postgres || local.is_mariadb ? "-" : ""
  major_version_substring               = local.is_mssql ? substr(local.major_version, 0, length(local.major_version) - 1) : local.major_version
  is_mssql                              = local.engine_class == "sqlserver"
  is_oracle                             = local.engine_class == "oracle"
  is_mariadb                            = local.engine_class == "mariadb"
  is_postgres                           = local.engine_class == "postgres"
  major_version                         = join(".", local.version_chunk[0])
  engine_class                          = element(split("-", var.engine), 0)
  version_chunk                         = chunklist(split(".", local.engine_version), local.is_single_major_version ? 1 : 2)
  engine_version                        = coalesce(var.engine_version, local.engine_defaults[local.engine_class]["version"])
  options                               = []
  subnet_group                          = length(aws_db_subnet_group.db_subnet_group.*.id) > 0 ? aws_db_subnet_group.db_subnet_group[0].id : var.existing_subnet_group
  parameter_group                       = length(aws_db_parameter_group.main.*.id) > 0 ? aws_db_parameter_group.main[0].id : var.existing_parameter_group_name
  option_group                          = length(aws_db_option_group.db_option_group.*.id) > 0 ? aws_db_option_group.db_option_group[0].id : var.existing_option_group_name
  performance_insights_enabled          = var.performance_insights_retention_period == 0 ? false : true
  performance_insights_retention_period = var.performance_insights_retention_period > 7 ? 731 : 7
  storage_size                          = coalesce(var.storage_size, lookup(local.engine_defaults[local.engine_class], "storage_size", 10))
  license_model                         = lookup(local.engine_defaults[local.engine_class], "license", null)
  port                                  = coalesce(var.port, lookup(local.engine_defaults[local.engine_class], "port", "3306"))

  is_single_major_version = contains(
    lookup(local.engine_defaults[local.engine_class], "single_major_version", []),
    element(split(".", local.engine_version), 0)
  )
  engine_defaults = {
    mariadb = {
      version = "10.4.13"
    }
    mysql = {
      version = "8.0.21"
    }
    oracle = {
      port                 = "1521"
      version              = "19.0.0.0.ru-2020-10.rur-2020-10.r1"
      storage_size         = "100"
      license              = "license-included"
      jdbc_proto           = "oracle:thin"
      single_major_version = ["18", "19"]
    }
    postgres = {
      port                 = "5432"
      version              = "12.4"
      jdbc_proto           = "postgresql"
      single_major_version = ["10", "11", "12"]
    }
    sqlserver = {
      port         = "1433"
      version      = "15.00.4043.16.v1"
      storage_size = "200"
      license      = "license-included"
      jdbc_proto   = "sqlserver"
    }
  }
  parameter_lookup = var.timezone == "" || local.is_mssql ? "none" : "timezone"
  parameters = {
    "none" = []
    "timezone" = [
      {
        name  = local.is_postgres ? "timezone" : "time_zone"
        value = var.timezone
      },
    ]
  }
  same_region_replica = var.read_replica && length(split(":", var.source_db)) == 1
}

resource "aws_db_subnet_group" "db_subnet_group" {
  count = var.enabled ? 1 : 0

  description = format("Database subnet group for%s%s", var.delimiter, module.labels.id)
  #  name_prefix = format("subnet%s%s", var.delimiter, module.labels.id)
  subnet_ids = var.subnet_ids
  tags       = module.labels.tags


  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_db_parameter_group" "main" {
  count = var.enabled ? 1 : 0

  description = format("Database parameter group for%s%s", var.delimiter, module.labels.id)
  name_prefix = format("subnet%s%s", module.labels.id, var.delimiter)
  family      = var.family

  dynamic "parameter" {
    for_each = concat(var.parameters, local.parameters[local.parameter_lookup])
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s%sparameter", module.labels.id, var.delimiter)
    }
  )
}

resource "aws_db_option_group" "db_option_group" {
  count = var.enabled ? 1 : 0

  engine_name              = var.engine
  major_engine_version     = var.major_engine_version
  name_prefix              = format("subnet%s%s", module.labels.id, var.delimiter)
  option_group_description = var.option_group_description == "" ? format("Option group for %s", module.labels.id) : var.option_group_description

  dynamic "option" {
    for_each = concat(var.options, local.options)
    content {
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", null)
        content {
          name  = lookup(option_settings.value, "name", null)
          value = lookup(option_settings.value, "value", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s%soption-group", module.labels.id, var.delimiter)
    }
  )

  timeouts {
    delete = lookup(var.option_group_timeouts, "delete", null)
  }
}

#tfsec:ignore:aws-rds-no-public-db-access
#tfsec:ignore:aws-rds-no-public-db-access
#tfsec:ignore:aws-rds-encrypt-instance-storage-data
resource "aws_db_instance" "this" {
  count = var.enabled ? 1 : 0

  identifier = module.labels.id

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = local.storage_size
  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id
  license_model     = var.license_model == "" ? local.license_model : var.license_model

  name                                = var.database_name
  username                            = var.username
  password                            = var.password
  port                                = local.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  snapshot_identifier = var.snapshot_identifier

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = join("", aws_db_subnet_group.db_subnet_group.*.id)
  parameter_group_name   = join("", aws_db_parameter_group.main.*.id)
  option_group_name      = join("", aws_db_option_group.db_option_group.*.id)

  availability_zone   = var.availability_zone
  multi_az            = var.multi_az
  iops                = var.iops
  publicly_accessible = var.publicly_accessible
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  skip_final_snapshot         = var.skip_final_snapshot
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  final_snapshot_identifier   = module.labels.id
  max_allocated_storage       = var.max_allocated_storage

  performance_insights_enabled          = local.performance_insights_enabled
  performance_insights_retention_period = local.performance_insights_enabled ? local.performance_insights_retention_period : null

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  character_set_name      = local.is_oracle ? var.character_set_name : null
  ca_cert_identifier      = var.ca_cert_identifier

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection      = var.deletion_protection
  delete_automated_backups = var.delete_automated_backups

  tags = module.labels.tags

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }

  depends_on = [
    aws_db_option_group.db_option_group,
    aws_db_parameter_group.main,
    aws_db_subnet_group.db_subnet_group,
  ]
}
