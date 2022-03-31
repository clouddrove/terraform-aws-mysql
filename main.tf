
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

resource "aws_db_subnet_group" "main" {
  count = var.enabled ? 1 : 0

  name_prefix = format("subnet%s%s", var.delimiter, module.labels.id)
  description = format("Database subnet group for%s%s", var.delimiter, module.labels.id)
  subnet_ids  = var.subnet_ids
  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s%ssubnet", module.labels.id, var.delimiter)
    }
  )
}

resource "aws_db_parameter_group" "main" {
  count = var.enabled && var.engine == "mysql" ? 1 : 0

  name_prefix = format("subnet%s%s", module.labels.id, var.delimiter)
  description = format("Database parameter group for%s%s", var.delimiter, module.labels.id)
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s%sparameter", module.labels.id, var.delimiter)
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_option_group" "main" {
  count = var.enabled ? 1 : 0

  name_prefix              = format("subnet%s%s", module.labels.id, var.delimiter)
  option_group_description = var.option_group_description == "" ? format("Option group for %s", module.labels.id) : var.option_group_description
  engine_name              = var.engine
  major_engine_version     = var.major_engine_version

  dynamic "option" {
    for_each = var.options
    content {
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = lookup(option.value, "db_security_group_memberships", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])
        content {
          name  = lookup(option_settings.value, "name", null)
          value = lookup(option_settings.value, "value", null)
        }
      }
    }
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

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "this" {
  count = var.enabled ? 1 : 0

  identifier = module.labels.id

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = true
  kms_key_id        = var.kms_key_id
  license_model     = var.engine != "mysql" ? "bring-your-own-license" : null

  name                                = var.database_name
  username                            = var.username
  password                            = var.password
  port                                = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  snapshot_identifier = var.snapshot_identifier

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = join("", aws_db_subnet_group.main.*.id)
  parameter_group_name   = var.engine == "mysql" ? join("", aws_db_parameter_group.main.*.id) : var.parameter_group_name
  option_group_name      = var.engine == "mysql" ? join("", aws_db_option_group.main.*.id) : var.option_group_name

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

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled == true ? var.performance_insights_retention_period : null

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  character_set_name = var.character_set_name

  ca_cert_identifier = var.ca_cert_identifier

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection      = var.deletion_protection
  delete_automated_backups = var.delete_automated_backups

  tags = module.labels.tags

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
}
