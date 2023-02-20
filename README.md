<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AWS Mysql
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Terraform module which creates RDS Aurora database resources on AWS and can create different type of databases. Currently it supports MySQL.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.1.7-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>
<a href="https://github.com/clouddrove/terraform-aws-mysql/actions/workflows/tfsec.yml">
  <img src="https://github.com/clouddrove/terraform-aws-mysql/actions/workflows/tfsec.yml/badge.svg" alt="tfsec">
</a>
<a href="https://github.com/clouddrove/terraform-aws-mysql/actions/workflows/terraform.yml">
  <img src="https://github.com/clouddrove/terraform-aws-mysql/actions/workflows/terraform.yml/badge.svg" alt="static-checks">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-mysql'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+Mysql&url=https://github.com/clouddrove/terraform-aws-mysql'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+Mysql&url=https://github.com/clouddrove/terraform-aws-mysql'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-mysql/releases).


Here are some examples of how you can use this module in your inventory structure:

###  MySQL
```hcl
  module "mysql" {
  source                      = "clouddrove/mysql/aws"
  version                     = "1.3.0"

    name          = "sg"
    environment   = "test"
    label_order = ["environment", "name"]

    engine            = "mysql"
    engine_version    = "5.7.19"
    instance_class    = "db.t2.small"
    allocated_storage = 5
    storage_encrypted = false

    # kms_key_id        = "arm:aws:kms:<region>:<accound id>:key/<kms key id>"

    # DB Details
    database_name = "test"
    username = "user"
    password = "esfsgcGdfawAhdxtfjm!"
    port     = "3306"

    vpc_security_group_ids = [module.security_group.security_group_ids]

    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_window      = "03:00-06:00"

    multi_az = true

    # disable backups to create DB faster
    backup_retention_period = 0

    enabled_cloudwatch_logs_exports = ["audit", "general"]

    # DB subnet group
    subnet_ids = module.subnets.public_subnet_id
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
```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocated\_storage | The allocated storage in gigabytes | `string` | `"20"` | no |
| allow\_major\_version\_upgrade | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| application | Application (e.g. `cd` or `clouddrove`). | `string` | `""` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| auto\_minor\_version\_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| availability\_zone | The Availability Zone of the RDS instance | `string` | `""` | no |
| backup\_retention\_period | The days to retain backups for | `number` | `1` | no |
| backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | `""` | no |
| ca\_cert\_identifier | Specifies the identifier of the CA certificate for the DB instance | `string` | `"rds-ca-2019"` | no |
| character\_set\_name | (Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information | `string` | `""` | no |
| copy\_tags\_to\_snapshot | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `bool` | `false` | no |
| create\_db\_instance | Whether to create a database instance | `bool` | `true` | no |
| create\_db\_option\_group | (Optional) Create a database option group | `bool` | `true` | no |
| create\_db\_parameter\_group | Whether to create a database parameter group | `bool` | `true` | no |
| create\_db\_subnet\_group | Whether to create a database subnet group | `bool` | `true` | no |
| create\_monitoring\_role | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `bool` | `false` | no |
| database\_name | database name for the master DB | `string` | `""` | no |
| db\_subnet\_group\_name | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| delete\_automated\_backups | Specifies whether to remove automated backups immediately after the DB instance is deleted | `bool` | `true` | no |
| deletion\_protection | The database can't be deleted when this value is set to true. | `bool` | `false` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| enabled | Whether to create this resource or not? | `bool` | `true` | no |
| enabled\_cloudwatch\_logs\_exports | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | <pre>[<br>  "general",<br>  "error",<br>  "slowquery"<br>]</pre> | no |
| engine | The database engine to use | `string` | `""` | no |
| engine\_version | The engine version to use | `string` | `""` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"test"` | no |
| existing\_option\_group\_name | The existing option group to use for this instance. (OPTIONAL) | `string` | `""` | no |
| existing\_parameter\_group\_name | The existing parameter group to use for this instance. (OPTIONAL) | `string` | `""` | no |
| existing\_subnet\_group | The existing DB subnet group to use for this instance (OPTIONAL) | `string` | `""` | no |
| family | The family of the DB parameter group | `string` | `""` | no |
| final\_snapshot\_identifier | The name of your final DB snapshot when this DB instance is deleted. | `string` | `false` | no |
| iam\_database\_authentication\_enabled | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `false` | no |
| instance\_class | The instance type of the RDS instance | `string` | `""` | no |
| iops | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' | `number` | `0` | no |
| kms\_key\_id | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| license\_model | License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1 | `string` | `""` | no |
| maintenance\_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | `""` | no |
| major\_engine\_version | Specifies the major version of the engine that this option group should be associated with | `string` | `""` | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| max\_allocated\_storage | Specifies the value for Storage Autoscaling | `number` | `0` | no |
| monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `""` | no |
| monitoring\_role\_name | Name of the IAM role which will be created when create\_monitoring\_role is enabled. | `string` | `"rds-monitoring-role"` | no |
| multi\_az | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `"clouddrove"` | no |
| option\_group\_description | The description of the option group | `string` | `""` | no |
| option\_group\_name | Name of the DB option group to associate | `string` | `""` | no |
| option\_group\_timeouts | Define maximum timeout for deletion of `aws_db_option_group` resource | `map(string)` | <pre>{<br>  "delete": "15m"<br>}</pre> | no |
| options | A list of Options to apply. | `list(any)` | `[]` | no |
| parameter\_group\_description | Description of the DB parameter group to create | `string` | `""` | no |
| parameter\_group\_name | Name of the DB parameter group to associate or create | `string` | `""` | no |
| parameters | A list of DB parameters (map) to apply | `list(map(string))` | `[]` | no |
| password | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | `""` | no |
| performance\_insights\_enabled | Specifies whether Performance Insights are enabled | `bool` | `false` | no |
| performance\_insights\_retention\_period | The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). | `number` | `0` | no |
| port | The port on which the DB accepts connections | `string` | `"3306"` | no |
| publicly\_accessible | Bool to control if instance is publicly accessible | `bool` | `false` | no |
| read\_replica | Specifies whether this RDS instance is a read replica. | `string` | `false` | no |
| replicate\_source\_db | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-mysql"` | no |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| snapshot\_identifier | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `""` | no |
| source\_db | The ID of the source DB instance.  For cross region replicas, the full ARN should be provided | `string` | `""` | no |
| storage\_encrypted | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `bool` | `true` | no |
| storage\_size | Select RDS Volume Size in GB. | `string` | `"50"` | no |
| storage\_type | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'. | `string` | `"gp2"` | no |
| subnet\_ids | A list of VPC subnet IDs | `list(string)` | `[]` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| timeouts | (Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times | `map(string)` | <pre>{<br>  "create": "40m",<br>  "delete": "40m",<br>  "update": "80m"<br>}</pre> | no |
| timezone | (Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information. | `string` | `""` | no |
| use\_parameter\_group\_name\_prefix | Whether to use the parameter group name prefix or not | `bool` | `true` | no |
| username | Username for the master DB user | `string` | `""` | no |
| vpc\_security\_group\_ids | List of VPC security groups to associate | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the cluster. |




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-aws-mysql/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-aws-mysql)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
