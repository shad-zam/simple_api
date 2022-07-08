
module "db_sg" {
  source      = "../terraform_modules/aws-sg"
  name        = "DB-sg"
  description = "Database sg"
  vpc_id      = module.vpc.vpc_id
  port_sg = {
    "3306" = [module.app_svr_sg.id]
  }

  tags = {
    Owner       = "Arshad"
    Environment = "non-prod"
  }

}

module "mysql" {
  source                     = "../terraform_modules/rds-db-instance"
  create                     = true
  db_instance_count          = 1
  identifier                 = "swisscom"
  allocated_storage          = 8
  engine                     = "mysql"
  engine_version             = "8.0"
  port                       = "3306"
  db_name                    = "mydb"
  username                   = "admin"
  password                   = "Password1"
  instance_class             = "db.t3.micro"
  auto_minor_version_upgrade = true
  backup_retention_period    = "0"
  vpc_security_group_ids     = ["${module.db_sg.id}"]
  subnet_ids                 = module.vpc.db_subnets
  create_db_subnet_group     = true


}

# output "endpoint" {
#   value = module.mysql.db_instance_endpoint[0]

# }


output "address" {
  value = module.mysql.db_instance_address[0]

}