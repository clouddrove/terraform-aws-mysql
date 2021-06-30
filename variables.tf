#Module      : LABEL
#Description : Terraform label module variables
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "application" {
  type        = string
  default     = ""
  description = "Application (e.g. `cd` or `clouddrove`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `environment`, `name` and `attributes`."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "enabled" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
}



variable "allocated_storage" {
  type        = string
  default     = "20"
  description = "The allocated storage in gigabytes"
}

variable "storage_type" {
  type        = string
  default     = "gp2"
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
}


variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  type        = string
  default     = ""
}

variable "replicate_source_db" {
  type        = string
  default     = ""
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
}

variable "license_model" {
  type        = string
  default     = ""
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"

}

variable "iam_database_authentication_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
}

variable "engine" {
  type        = string
  default     = ""
  description = "The database engine to use"
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "The engine version to use"
}

variable "final_snapshot_identifier" {
  type        = string
  default     = false
  description = "The name of your final DB snapshot when this DB instance is deleted."
}

variable "instance_class" {
  type        = string
  default     = ""
  description = "The instance type of the RDS instance"

}

variable "database_name" {
  type        = string
  default     = ""
  description = "database name for the master DB"

}

variable "username" {
  type        = string
  default     = ""
  description = "Username for the master DB user"
}

variable "password" {
  type        = string
  default     = ""
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
}

variable "port" {
  type        = string
  default     = "3306"
  description = "The port on which the DB accepts connections"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of VPC security groups to associate"
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
}

variable "parameter_group_description" {
  type        = string
  default     = ""
  description = "Description of the DB parameter group to create"
}

variable "parameter_group_name" {
  type        = string
  default     = ""
  description = "Name of the DB parameter group to associate or create"
}

variable "option_group_name" {
  type        = string
  default     = ""
  description = "Name of the DB option group to associate"
}

variable "availability_zone" {
  type        = string
  default     = ""
  description = "The Availability Zone of the RDS instance"
}


variable "iops" {
  type        = number
  default     = 0
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Bool to control if instance is publicly accessible"
}

variable "monitoring_interval" {
  type        = number
  default     = 1
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
}

variable "monitoring_role_arn" {
  type        = string
  default     = ""
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
}


variable "monitoring_role_name" {
  type        = string
  default     = "rds-monitoring-role"
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
}

variable "create_monitoring_role" {
  type        = bool
  default     = false
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
}

variable "allow_major_version_upgrade" {
  type        = bool
  default     = false
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = true
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
}

variable "maintenance_window" {
  type        = string
  default     = ""
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
}

variable "copy_tags_to_snapshot" {
  type        = bool
  default     = false
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
}

variable "backup_retention_period" {
  type        = number
  default     = 1
  description = "The days to retain backups for"
}

variable "backup_window" {
  type        = string
  default     = ""
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
}

# DB subnet group
variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of VPC subnet IDs"
}

# DB parameter group
variable "family" {
  type        = string
  default     = ""
  description = "The family of the DB parameter group"
}

variable "parameters" {
  type        = list(map(string))
  default     = []
  description = "A list of DB parameters (map) to apply"
}

# DB option group
variable "option_group_description" {
  type        = string
  default     = ""
  description = "The description of the option group"
}

variable "major_engine_version" {
  type        = string
  default     = ""
  description = "Specifies the major version of the engine that this option group should be associated with"
}

variable "options" {
  type        = any
  default     = []
  description = "A list of Options to apply."
}

variable "create_db_subnet_group" {
  type        = bool
  default     = true
  description = "Whether to create a database subnet group"
}

variable "create_db_parameter_group" {
  type        = bool
  default     = true
  description = "Whether to create a database parameter group"
}

variable "create_db_option_group" {
  type        = bool
  default     = true
  description = "(Optional) Create a database option group"
}

variable "create_db_instance" {
  type        = bool
  default     = true
  description = "Whether to create a database instance"
}

variable "timezone" {
  type        = string
  default     = ""
  description = "(Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information."
}

variable "character_set_name" {
  type        = string
  default     = ""
  description = "(Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = ["general", "error", "slowquery"]
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
}

variable "timeouts" {
  type = map(string)
  default = {
    create = "40m"
    update = "80m"
    delete = "40m"
  }
  description = "(Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
}

variable "option_group_timeouts" {
  type = map(string)
  default = {
    delete = "15m"
  }
  description = "Define maximum timeout for deletion of `aws_db_option_group` resource"
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "The database can't be deleted when this value is set to true."
}

variable "use_parameter_group_name_prefix" {
  type        = bool
  default     = true
  description = "Whether to use the parameter group name prefix or not"
}

variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Performance Insights are enabled"
}

variable "performance_insights_retention_period" {
  type        = number
  default     = 7
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)."
}

variable "max_allocated_storage" {
  type        = number
  default     = 0
  description = "Specifies the value for Storage Autoscaling"
}

variable "ca_cert_identifier" {
  type        = string
  default     = "rds-ca-2019"
  description = "Specifies the identifier of the CA certificate for the DB instance"
}

variable "delete_automated_backups" {
  type        = bool
  default     = true
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Specifies if the RDS instance is multi-AZ"
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-mysql"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}
