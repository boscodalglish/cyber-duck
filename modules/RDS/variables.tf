variable "allocated_storage" {
}

variable "engine" {
}

variable "engine_version" {
}

variable "instance_class" {
}

variable "name" {
}

variable "identifier" {
}

variable "environment" {
}

variable "username" {
}

variable "password" {
}

variable "multi_az" {
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "monitoring_interval" {
  default = 0
}

variable "backup_retention" {
  default = 0
}

variable "tag_live" {
}

variable "tag_workload-type" {
}

variable "ssm_param_name" {
}

variable "final_snapshot" {
  
}