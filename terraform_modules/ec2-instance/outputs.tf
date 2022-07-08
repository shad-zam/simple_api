output "id" {
  description = "The ID of the instance"
  value       = try(aws_instance.this.*.id, [""])
}

output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_instance.this.*.arn, [""])
}


output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = try(aws_instance.this.*.instance_state, [""])
}


output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = try(aws_instance.this.*.primary_network_interface_id, [""])
}

output "private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = try(aws_instance.this.*.private_dns, [""])
}

output "public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = try(aws_instance.this.*.public_dns, [""])
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = try(aws_instance.this.*.public_ip, [""])
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.this.*.private_ip, [""])
}

output "tags" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value       = try(aws_instance.this.*.tags, [""])
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = try(aws_instance.this.*.volume_tags, [""])
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = try(aws_instance.this.*.availability_zone, [""])
}

output "placement_group" {
  description = "List of placement groups of instances"
  value       = try(aws_instance.this.*.placement_group, [""])
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = try(aws_instance.this.*.security_groups, [""])
}


output "password_data" {
  description = "List of Base-64 encoded encrypted password data for the instance"
  value       = try(aws_instance.this.*.password_data, [""])
}


output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = try(aws_instance.this.*.subnet_id, [""])
}

output "credit_specification" {
  description = "List of credit specification of instances"
  value       = try(aws_instance.this.*.credit_specification)
}