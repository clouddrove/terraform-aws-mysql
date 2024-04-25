## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias | The display name of the alias. The name must start with the word `alias` followed by a forward slash. | `string` | `"alias/rds"` | no |
| allocated\_storage | The allocated storage in gigabytes | `string` | `null` | no |
| allow\_major\_version\_upgrade | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| allowed\_ip | List of allowed ip. | `list(any)` | `[]` | no |
| allowed\_ports | List of allowed ingress ports | `list(any)` | `[]` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| availability\_zone | The Availability Zone of the RDS instance | `string` | `null` | no |
| backup\_retention\_period | The days to retain backups for | `number` | `null` | no |
| backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | `null` | no |
| blue\_green\_update | Enables low-downtime updates using RDS Blue/Green deployments. | `map(string)` | `{}` | no |
| ca\_cert\_identifier | Specifies the identifier of the CA certificate for the DB instance | `string` | `null` | no |
| character\_set\_name | The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS and Collations and Character Sets for Microsoft SQL Server for more information. This can only be set on creation. | `string` | `null` | no |
| cloudwatch\_log\_group\_retention\_in\_days | The number of days to retain CloudWatch logs for the DB instance | `number` | `7` | no |
| cloudwatch\_log\_group\_tags | Additional tags for the cloudwatch log group | `map(any)` | `{}` | no |
| copy\_tags\_to\_snapshot | On delete, copy all Instance tags to the final snapshot | `bool` | `true` | no |
| custom\_iam\_instance\_profile | RDS custom iam instance profile | `string` | `null` | no |
| customer\_master\_key\_spec | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC\_DEFAULT, RSA\_2048, RSA\_3072, RSA\_4096, ECC\_NIST\_P256, ECC\_NIST\_P384, ECC\_NIST\_P521, or ECC\_SECG\_P256K1. Defaults to SYMMETRIC\_DEFAULT. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| db\_instance\_read\_tags | Additional tags for the DB instance | `map(any)` | `{}` | no |
| db\_instance\_this\_tags | Additional tags for the DB instance | `map(any)` | `{}` | no |
| db\_name | The DB name to create. If omitted, no database is created initially | `string` | `null` | no |
| db\_option\_group\_tags | Additional tags for the DB option group | `map(any)` | `{}` | no |
| db\_parameter\_group\_tags | Additional tags for the  DB parameter group | `map(any)` | `{}` | no |
| db\_subnet\_group\_name | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| db\_subnet\_group\_tags | Additional tags for the DB subnet group | `map(any)` | `{}` | no |
| delete\_automated\_backups | Specifies whether to remove automated backups immediately after the DB instance is deleted | `bool` | `true` | no |
| deletion\_protection | The database can't be deleted when this value is set to true. | `bool` | `true` | no |
| deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource. | `number` | `7` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| domain | The ID of the Directory Service Active Directory domain to create the instance in | `string` | `null` | no |
| domain\_iam\_role\_name | (Required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service | `string` | `null` | no |
| egress\_rule | Enable to create egress rule | `bool` | `true` | no |
| enable\_key\_rotation | Specifies whether key rotation is enabled. | `string` | `true` | no |
| enable\_security\_group | Enable default Security Group with only Egress traffic allowed. | `bool` | `true` | no |
| enabled | Whether to create this resource or not? | `bool` | `true` | no |
| enabled\_cloudwatch\_log\_group | Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports` | `bool` | `false` | no |
| enabled\_cloudwatch\_logs\_exports | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | `[]` | no |
| enabled\_db\_subnet\_group | A list of enabled db subnet group | `bool` | `true` | no |
| enabled\_monitoring\_role | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `bool` | `false` | no |
| enabled\_read\_replica | A list of enabled read replica | `bool` | `true` | no |
| enabled\_replica | A list of enabled replica | `bool` | `false` | no |
| engine | The database engine to use | `string` | `"mysql"` | no |
| engine\_name | Specifies the name of the engine that this option group should be associated with | `string` | `"mysql"` | no |
| engine\_version | The engine version to use | `string` | `null` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| family | The family of the DB parameter group | `string` | `null` | no |
| iam\_database\_authentication\_enabled | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `true` | no |
| identifier | The name of the RDS instance | `string` | `""` | no |
| instance\_class | The instance type of the RDS instance | `string` | `null` | no |
| iops | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' or `gp3`. See `notes` for limitations regarding this variable for `gp3` | `number` | `null` | no |
| is\_enabled | Specifies whether the key is enabled. | `bool` | `true` | no |
| is\_external | enable to udated existing security Group | `bool` | `false` | no |
| key\_usage | Specifies the intended use of the key. Defaults to ENCRYPT\_DECRYPT, and only symmetric encryption and decryption are supported. | `string` | `"ENCRYPT_DECRYPT"` | no |
| kms\_description | The description of the key as viewed in AWS console. | `string` | `"Parameter Store KMS master key"` | no |
| kms\_key\_enabled | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| kms\_key\_id | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| kms\_multi\_region | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `false` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| license\_model | License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1 | `string` | `null` | no |
| maintenance\_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | `null` | no |
| major\_engine\_version | Specifies the major version of the engine that this option group should be associated with | `string` | `null` | no |
| managedby | ManagedBy, eg 'pps'. | `string` | `"ctr.anmol.nagpal@prth.com"` | no |
| max\_allocated\_storage | Specifies the value for Storage Autoscaling | `number` | `0` | no |
| monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| monitoring\_role\_description | Description of the monitoring IAM role | `string` | `null` | no |
| monitoring\_role\_name | Name of the IAM role which will be created when create\_monitoring\_role is enabled. | `string` | `"rds-monitoring-role"` | no |
| monitoring\_role\_permissions\_boundary | ARN of the policy that is used to set the permissions boundary for the monitoring IAM role | `string` | `null` | no |
| multi\_az | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| mysql\_iam\_role\_tags | Additional tags for the mysql iam role | `map(any)` | `{}` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| network\_type | The type of network stack | `string` | `null` | no |
| option\_group\_description | The description of the option group | `string` | `null` | no |
| options | A list of Options to apply | `any` | `[]` | no |
| parameters | A list of DB parameter maps to apply | `list(map(string))` | `[]` | no |
| password | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | `null` | no |
| performance\_insights\_enabled | Specifies whether Performance Insights are enabled | `bool` | `false` | no |
| performance\_insights\_kms\_key\_id | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `null` | no |
| performance\_insights\_retention\_period | The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). | `number` | `7` | no |
| port | The port on which the DB accepts connections | `string` | `null` | no |
| protocol | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| publicly\_accessible | Bool to control if instance is publicly accessible | `bool` | `false` | no |
| replica\_instance\_class | The instance type of the RDS instance | `string` | `""` | no |
| replica\_mode | Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specified | `string` | `null` | no |
| replicate\_source\_db | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. | `string` | `null` | no |
| restore\_to\_point\_in\_time | Restore to a point in time (MySQL is NOT supported) | `map(string)` | `null` | no |
| s3\_import | Restore from a Percona Xtrabackup in S3 (only MySQL is supported) | `map(string)` | `null` | no |
| sg\_description | The security group description. | `string` | `"Instance default security group (only egress access is allowed)."` | no |
| sg\_egress\_description | Description of the egress and ingress rule | `string` | `"Description of the rule."` | no |
| sg\_egress\_ipv6\_description | Description of the egress\_ipv6 rule | `string` | `"Description of the rule."` | no |
| sg\_ids | of the security group id. | `list(any)` | `[]` | no |
| sg\_ingress\_description | Description of the ingress rule | `string` | `"Description of the ingress rule use elasticache."` | no |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted | `bool` | `true` | no |
| snapshot\_identifier | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `""` | no |
| ssm\_parameter\_description | SSM Parameters can be imported using. | `string` | `"Description of the parameter."` | no |
| ssm\_parameter\_endpoint\_enabled | Name of the parameter. | `bool` | `false` | no |
| ssm\_parameter\_type | Type of the parameter. | `string` | `"SecureString"` | no |
| storage\_encrypted | Specifies whether the DB instance is encrypted | `bool` | `true` | no |
| storage\_throughput | Storage throughput value for the DB instance. This setting applies only to the `gp3` storage type. See `notes` for limitations regarding this variable for `gp3` | `number` | `null` | no |
| storage\_type | One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter | `string` | `null` | no |
| subnet\_ids | A list of VPC Subnet IDs to launch in. | `list(string)` | `[]` | no |
| timeouts | Define maximum timeout for deletion of `aws_db_option_group` resource | `map(string)` | `{}` | no |
| timezone | Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information. | `string` | `null` | no |
| use\_identifier\_prefix | Determines whether to use `identifier` as is or create a unique identifier beginning with `identifier` as the specified prefix | `bool` | `false` | no |
| username | Username for the master DB user | `string` | `null` | no |
| vpc\_id | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| db\_instance\_address | The address of the RDS instance |
| db\_instance\_arn | The ARN of the RDS instance |
| db\_instance\_availability\_zone | The availability zone of the RDS instance |
| db\_instance\_ca\_cert\_identifier | Specifies the identifier of the CA certificate for the DB instance |
| db\_instance\_cloudwatch\_log\_groups | Map of CloudWatch log groups created and their attributes |
| db\_instance\_domain | The ID of the Directory Service Active Directory domain the instance is joined to |
| db\_instance\_domain\_iam\_role\_name | The name of the IAM role to be used when making API calls to the Directory Service. |
| db\_instance\_endpoint | The connection endpoint |
| db\_instance\_engine | The database engine |
| db\_instance\_hosted\_zone\_id | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| db\_instance\_id | The RDS instance ID |
| db\_instance\_name | The database name |
| db\_instance\_password | The master password |
| db\_instance\_port | The database port |
| db\_instance\_resource\_id | The RDS Resource ID of this instance |
| db\_instance\_status | The RDS instance status |
| db\_instance\_username | The master username for the database |
| db\_parameter\_group\_arn | The ARN of the db parameter group |
| db\_parameter\_group\_id | The db parameter group id |
| db\_subnet\_group\_id | The db subnet group name |
| db\_subnet\_group\_name | The db subnet group name |
| enhanced\_monitoring\_iam\_role\_arn | The Amazon Resource Name (ARN) specifying the monitoring role |
| enhanced\_monitoring\_iam\_role\_name | The name of the monitoring role |

