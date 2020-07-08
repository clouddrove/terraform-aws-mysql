output "id" {
  value       = aws_db_option_group.main.*.id
  description = "The ID of the cluster."
}
