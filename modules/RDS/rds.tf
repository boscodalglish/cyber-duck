resource "aws_db_instance" "instance" {
  allocated_storage         = var.allocated_storage
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  db_name                   = var.name
  identifier                = var.identifier
  username                  = var.username
  password                  = var.password
  db_subnet_group_name      = aws_db_subnet_group.default.id
  storage_encrypted         = true
  monitoring_interval       = var.monitoring_interval
  multi_az                  = var.multi_az
  copy_tags_to_snapshot     = true
  apply_immediately         = true
  skip_final_snapshot       = false
  final_snapshot_identifier = var.final_snapshot
  storage_type              = "gp2"
  vpc_security_group_ids    = var.security_groups
  backup_retention_period   = var.backup_retention

  tags = {
    "workload-type"      = var.tag_workload-type
    "Name"               = "rds-${var.environment}-${var.name}"
    "owner"              = "Dalglish Fernandes"
    "email"              = "dalglishxy@gmail.com"
    "project"            = "cyber-duck-test"
    "live"               = var.tag_live
    "environment"        = var.environment
    "dataRetention"      = "greater-than-7-years",
    "dataClassification" = "confidential"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "sg-${var.identifier}"
  subnet_ids = var.subnets
}

resource "aws_ssm_parameter" "host" {
  name        = "/config/application_${var.environment}/${var.ssm_param_name}.host"
  description = "${var.identifier} hostname"
  type        = "String"
  value       = aws_db_instance.instance.address
}

resource "aws_ssm_parameter" "port" {
  name        = "/config/application_${var.environment}/${var.ssm_param_name}.port"
  description = "${var.identifier} port"
  type        = "String"
  value       = aws_db_instance.instance.port
}

resource "aws_ssm_parameter" "name" {
  name        = "/config/application_${var.environment}/${var.ssm_param_name}.name"
  description = "${var.identifier} DB name"
  type        = "String"
  value       = aws_db_instance.instance.name
}

resource "aws_ssm_parameter" "username" {
  name        = "/config/application_${var.environment}/${var.ssm_param_name}.username"
  description = "${var.identifier} username"
  type        = "String"
  value       = aws_db_instance.instance.username
}

resource "aws_ssm_parameter" "secret" {
  name        = "/config/application_${var.environment}/${var.ssm_param_name}.password"
  description = "${var.identifier} password"
  type        = "SecureString"
  value       = var.password
}
