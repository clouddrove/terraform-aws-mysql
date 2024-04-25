output "db_instance_arn" {
  value       = module.mariadb.db_instance_arn
  description = "The ARN of the RDS instance"
}

output "db_instance_availability_zone" {
  value       = module.mariadb.db_instance_availability_zone
  description = "The availability zone of the RDS instance"
}

output "db_instance_endpoint" {
  value       = module.mariadb.db_instance_endpoint
  description = "The connection endpoint"
}

output "db_instance_engine" {
  value       = module.mariadb.db_instance_engine
  description = "The database engine"
}

output "db_instance_id" {
  value       = module.mariadb.db_instance_id
  description = "The RDS instance ID"
}

