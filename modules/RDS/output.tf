output "address" {
  value = split(":", aws_db_instance.instance.endpoint)
}

output "id" {
  value = aws_db_instance.instance.id
}
