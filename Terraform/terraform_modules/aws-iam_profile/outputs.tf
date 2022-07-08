output "id" {
  description = "The instance profile's ID"
  value       = aws_iam_instance_profile.ec2_profile.id
}

output "name" {
  description = "The instance profile's name"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "arn" {
  description = "The ARN assigned by AWS to the instance profile."
  value       = aws_iam_instance_profile.ec2_profile.arn
}

output "role" {
  description = "The role assigned to the instance profile"
  value       = aws_iam_instance_profile.ec2_profile.arn
}