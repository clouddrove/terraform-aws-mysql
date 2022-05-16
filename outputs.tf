output "id" {
  value       = aws_db_option_group.db_option_group.*.id
  description = "The ID of the cluster."
}
