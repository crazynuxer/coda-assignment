output "arn" {
  description = "IAM role arn"
  value       = aws_iam_role.main.arn
}

output "name" {
  description = "IAM role name"
  value       = aws_iam_role.main.name
}

output "instance_profile_arn" {
  description = "IAM instance profile arn"
  value       = try(aws_iam_instance_profile.main[0].arn, null)
}
