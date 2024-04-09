output "db_instance_address" {
  value       = module.mysql.db_instance_address
  description = "The address of the RDS instance"
}

output "db_instance_arn" {
  value       = module.mysql.db_instance_arn
  description = "The ARN of the RDS instance"
}

output "db_instance_availability_zone" {
  value       = module.mysql.db_instance_availability_zone
  description = "The availability zone of the RDS instance"
}

output "db_instance_endpoint" {
  value       = module.mysql.db_instance_endpoint
  description = "The connection endpoint"
}

output "db_instance_engine" {
  value       = module.mysql.db_instance_engine
  description = "The database engine"
}

output "db_instance_hosted_zone_id" {
  value       = module.mysql.db_instance_hosted_zone_id
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
}

output "db_instance_id" {
  value       = module.mysql.db_instance_id
  description = "The RDS instance ID"
}

output "db_instance_resource_id" {
  value       = module.mysql.db_instance_resource_id
  description = "The RDS Resource ID of this instance"
}

output "db_instance_status" {
  value       = module.mysql.db_instance_status
  description = "The RDS instance status"
}

output "db_instance_name" {
  value       = module.mysql.db_instance_name
  description = "The database name"
}
