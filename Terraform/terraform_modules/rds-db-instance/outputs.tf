
output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = try(aws_db_subnet_group.this.*.id,"")
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = try(aws_db_subnet_group.this.*.arn, "")
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = try(aws_db_instance.this.*.address, "")
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = try(aws_db_instance.this.*.arn,"")
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = try(aws_db_instance.this.*.availability_zone, "")
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = try(aws_db_instance.this.*.endpoint,"")
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = try(aws_db_instance.this.*.hosted_zone_id,"")
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = try(aws_db_instance.this.*.id,"")
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = try(aws_db_instance.this.*.resource_id,"")
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = try(aws_db_instance.this.*.status,"")
}

output "db_instance_name" {
  description = "The database name"
  value       = try(aws_db_instance.this.*.db_name,"")
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = try(aws_db_instance.this.*.username,"")
}

output "db_instance_port" {
  description = "The database port"
  value       = try(aws_db_instance.this.*.port,"")
}


