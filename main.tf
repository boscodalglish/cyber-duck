provider "aws" {
    region      = "eu-west-1"
    max_retries = 5
    default_tags {
        tags = {
            "owner"              = "Dalglish Fernandes"
            "email"              = "dalglishxy@gmail.com"
            "project"            = "cyber-duck-test"
            "live"               = "no"
            "environment"        = local.environment
            "dataRetention"      = "greater-than-7-years",
            "dataClassification" = "confidential"
        }
    }
}

locals {
    environment = "non-prod"
}

module "rds" {
    source            = "./modules/RDS"
    allocated_storage = 10
    engine            = "mysql"
    engine_version    = "5.7"
    instance_class    = "db.t4g "
    name              = "db-test"
    username          = "mysqluser"
    multi_az          = "true"
    password          = var.db_pw
    # subnets id and vpc_security_group_ids are reqired for RDS to be created in private subnet
    subnets           = module.infra.private_subnet_ids
    security_groups   = [module.eks.worker_security_group_id]
    tag_live          = "no"
    tag_workload-type = "other"
    backup_retention  = "30"
    environment       = "${local.environment}"
    identifier        = "${local.environment}-db"
    ssm_param_name    = "db"
    final_snapshot    = "${local.environment}-db-snapshot"
}
