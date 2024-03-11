## TASK DEFINITION
output "arn" {
  description = "The ARN of the task definition."
  value       = aws_ecs_task_definition.main.arn
}

output "task_role_name" {
  description = "The name of the IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  value       = try(module.iam_role_ecs_task[0].name, null)
}

output "task_role_arn" {
  description = "The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  value       = try(module.iam_role_ecs_task[0].arn, null)
}

output "execution_role_name" {
  description = "The name of the IAM role that grants the Amazon ECS container agent permission to make calls to your Amazon ECS container task."
  value       = try(module.iam_role_ecs_exec[0].name, null)
}

output "execution_role_arn" {
  description = "The ARN of the IAM role that grants the Amazon ECS container agent permission to make calls to your Amazon ECS container task."
  value       = try(module.iam_role_ecs_exec[0].arn, null)
}
