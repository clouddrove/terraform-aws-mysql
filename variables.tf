#Module      : LABEL
#Description : Terraform label module variables
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
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

variable "managedby" {
  type        = string
  default     = "ctr.anmol.nagpal@prth.com"
  description = "ManagedBy, eg 'pps'."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `environment`, `name` and `attributes`."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create this resource or not?"
}

variable "identifier" {
  type        = string
  default     = ""
  description = "The name of the RDS instance"
}

variable "custom_iam_instance_profile" {
  type        = string
  default     = null
  description = "RDS custom iam instance profile"
}

variable "use_identifier_prefix" {
  description = "Determines whether to use `identifier` as is or create a unique identifier beginning with `identifier` as the specified prefix"
  type        = bool
  default     = false
}

variable "allocated_storage" {
  type        = string
  default     = null
  description = "The allocated storage in gigabytes"
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
  type        = string
  default     = null
}

variable "storage_throughput" {
  type        = number
  default     = null
  description = "Storage throughput value for the DB instance. This setting applies only to the `gp3` storage type. See `notes` for limitations regarding this variable for `gp3`"
}

variable "storage_encrypted" {
  type        = bool
  default     = true
  description = "Specifies whether the DB instance is encrypted"
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
}

variable "replicate_source_db" {
  type        = string
  default     = null
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
}

variable "license_model" {
  type        = string
  default     = null
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
}

variable "replica_mode" {
  type        = string
  default     = null
  description = "Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specified"
}

variable "iam_database_authentication_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
}

variable "domain" {
  type        = string
  default     = null
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
}

variable "domain_iam_role_name" {
  type        = string
  default     = null
  description = "(Required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  type        = string
  default     = null
  description = "The engine version to use"
}

variable "instance_class" {
  type        = string
  default     = null
  description = "The instance type of the RDS instance"
}

variable "db_name" {
  type        = string
  default     = null
  description = "The DB name to create. If omitted, no database is created initially"
}

variable "username" {
  type        = string
  default     = null
  description = "Username for the master DB user"
}

variable "password" {
  type        = string
  default     = null
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
}

variable "port" {
  type        = string
  default     = null
  description = "The port on which the DB accepts connections"
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted"
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
}

variable "copy_tags_to_snapshot" {
  type        = bool
  default     = true
  description = "On delete, copy all Instance tags to the final snapshot"
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = null
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Specifies if the RDS instance is multi-AZ"
}

variable "iops" {
  type        = number
  default     = null
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' or `gp3`. See `notes` for limitations regarding this variable for `gp3`"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Bool to control if instance is publicly accessible"
}

variable "monitoring_interval" {
  type        = number
  default     = 0
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
}

variable "monitoring_role_arn" {
  type        = string
  default     = null
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
}

variable "monitoring_role_description" {
  type        = string
  default     = null
  description = "Description of the monitoring IAM role"
}

variable "monitoring_role_permissions_boundary" {
  type        = string
  default     = null
  description = "ARN of the policy that is used to set the permissions boundary for the monitoring IAM role"
}

variable "enabled_monitoring_role" {
  type        = bool
  default     = false
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = true
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  type        = string
  default     = null
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
}

variable "blue_green_update" {
  description = "Enables low-downtime updates using RDS Blue/Green deployments."
  type        = map(string)
  default     = {}
}

variable "backup_retention_period" {
  type        = number
  default     = null
  description = "The days to retain backups for"
}

variable "backup_window" {
  type        = string
  default     = null
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
}

variable "timezone" {
  type        = string
  default     = null
  description = "Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information."
}

variable "character_set_name" {
  type        = string
  default     = null
  description = "The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS and Collations and Character Sets for Microsoft SQL Server for more information. This can only be set on creation."
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = []
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "The database can't be deleted when this value is set to true."
}

#tfsec:ignore:aws-rds-enable-performance-insights
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

variable "performance_insights_kms_key_id" {
  type        = string
  default     = null
  description = "The ARN for the KMS key to encrypt Performance Insights data."
}

variable "max_allocated_storage" {
  type        = number
  default     = 0
  description = "Specifies the value for Storage Autoscaling"
}

variable "ca_cert_identifier" {
  type        = string
  default     = null
  description = "Specifies the identifier of the CA certificate for the DB instance"
}

variable "delete_automated_backups" {
  type        = bool
  default     = true
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
}

variable "s3_import" {
  type        = map(string)
  default     = null
  description = "Restore from a Percona Xtrabackup in S3 (only MySQL is supported)"
}

variable "restore_to_point_in_time" {
  type        = map(string)
  default     = null
  description = "Restore to a point in time (MySQL is NOT supported)"
}

variable "network_type" {
  type        = string
  default     = null
  description = "The type of network stack"
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "enabled_cloudwatch_log_group" {
  type        = bool
  default     = false
  description = "Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports`"
}

variable "cloudwatch_log_group_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to retain CloudWatch logs for the DB instance"
}

variable "source_db_instance_arn" {
  type        = string
  default     = ""
  description = "The ARN of the source DB instance for the replicated automated backups"
}

variable "use_name_prefix" {
  type        = bool
  default     = false
  description = "Determines whether to use `name` as is or create a unique name beginning with `name` as the specified prefix"
}

variable "option_group_description" {
  type        = string
  default     = null
  description = "The description of the option group"
}

variable "engine_name" {
  type        = string
  default     = "mysql"
  description = "Specifies the name of the engine that this option group should be associated with"
}

variable "major_engine_version" {
  type        = string
  default     = null
  description = "Specifies the major version of the engine that this option group should be associated with"
}

variable "options" {
  type        = any
  default     = []
  description = "A list of Options to apply"
}

variable "timeouts" {
  type        = map(string)
  default     = {}
  description = "Define maximum timeout for deletion of `aws_db_option_group` resource"
}

variable "family" {
  type        = string
  default     = null
  description = "The family of the DB parameter group"
}

variable "parameters" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of VPC Subnet IDs to launch in."
}

variable "enabled_db_subnet_group" {
  type        = bool
  default     = true
  description = "A list of enabled db subnet group"
}

variable "replica_instance_class" {
  type        = string
  default     = ""
  description = "The instance type of the RDS instance"
}

variable "enabled_read_replica" {
  type        = bool
  default     = true
  description = "A list of enabled read replica"
}

variable "enabled_replica" {
  type        = bool
  default     = false
  description = "A list of enabled replica"
}

variable "db_subnet_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the DB subnet group"
}

variable "db_parameter_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the  DB parameter group"
}

variable "db_option_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the DB option group"
}

variable "cloudwatch_log_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the cloudwatch log group"
}

variable "mysql_iam_role_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the mysql iam role"
}

variable "db_instance_this_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the DB instance"
}

variable "db_instance_read_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the DB instance"
}

variable "enable_security_group" {
  type        = bool
  default     = true
  description = "Enable default Security Group with only Egress traffic allowed."
}

variable "sg_ids" {
  type        = list(any)
  default     = []
  description = "of the security group id."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
  sensitive   = true
}

variable "sg_description" {
  type        = string
  default     = "Instance default security group (only egress access is allowed)."
  description = "The security group description."
}

variable "is_external" {
  type        = bool
  default     = false
  description = "enable to udated existing security Group"
}

variable "existing_sg_id" {
  type        = string
  default     = null
  description = "Provide existing security group id for updating existing rule"
}

variable "egress_rule" {
  type        = bool
  default     = true
  description = "Enable to create egress rule"
}

variable "sg_egress_description" {
  type        = string
  default     = "Description of the rule."
  description = "Description of the egress and ingress rule"
}

variable "sg_egress_ipv6_description" {
  type        = string
  default     = "Description of the rule."
  description = "Description of the egress_ipv6 rule"
}

variable "allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed ip."
}

variable "allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "sg_ingress_description" {
  type        = string
  default     = "Description of the ingress rule use elasticache."
  description = "Description of the ingress rule"
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "kms_key_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the kms is enabled or disabled."
}

variable "kms_description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console."
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  sensitive   = true
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported."
}

variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Duration in days after which the key is deleted after destruction of the resource."
}

variable "is_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the key is enabled."
}

variable "enable_key_rotation" {
  type        = string
  default     = true
  description = "Specifies whether key rotation is enabled."
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT."
  sensitive   = true
}

variable "kms_multi_region" {
  type        = bool
  default     = false
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}

variable "alias" {
  type        = string
  default     = "alias/rds"
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash."
}

variable "ssm_parameter_description" {
  type        = string
  default     = "Description of the parameter."
  description = "SSM Parameters can be imported using."
}

variable "ssm_parameter_type" {
  type        = string
  default     = "SecureString"
  description = "Type of the parameter."
}

variable "ssm_parameter_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Name of the parameter."
}
