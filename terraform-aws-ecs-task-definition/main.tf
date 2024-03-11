/**
 * # Terraform AWS ECS Task Definition Module
 *
 * Terraform module for creating an AWS ECS Task Definition.
 */
resource "aws_ecs_task_definition" "main" {
  family = var.name

  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities

  execution_role_arn = var.create_execution_role ? module.iam_role_ecs_exec[0].arn : var.execution_role_arn
  task_role_arn      = var.create_task_role ? module.iam_role_ecs_task[0].arn : var.task_role_arn

  cpu                   = var.cpu
  memory                = var.memory
  container_definitions = jsonencode(var.container_definitions)

  runtime_platform {
    operating_system_family = var.operating_system_family
    cpu_architecture        = var.cpu_architecture
  }

  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage_size_in_gib > 20 ? [true] : []

    content {
      size_in_gib = var.ephemeral_storage_size_in_gib
    }
  }

  dynamic "volume" {
    for_each = var.volumes

    content {
      name      = volume.value.name
      host_path = volume.value.host_path
      #host_path = volume.value.type != "ephemeral" ? volume.value.host_path : null

      dynamic "docker_volume_configuration" {
        for_each = volume.value.docker_volume_configuration != null ? [volume.value.docker_volume_configuration] : []

        content {
          autoprovision = docker_volume_configuration.value.autoprovision
          driver        = docker_volume_configuration.value.driver
          driver_opts   = docker_volume_configuration.value.driver_opts
          labels        = docker_volume_configuration.value.labels
          scope         = docker_volume_configuration.value.scope
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = volume.value.efs_volume_configuration != null ? [volume.value.efs_volume_configuration] : []

        content {
          file_system_id          = efs_volume_configuration.value.file_system_id
          root_directory          = efs_volume_configuration.value.root_directory
          transit_encryption      = efs_volume_configuration.value.transit_encryption
          transit_encryption_port = efs_volume_configuration.value.transit_encryption_port

          dynamic "authorization_config" {
            for_each = efs_volume_configuration.value.authorization_config != null ? [
              efs_volume_configuration.value.authorization_config
            ] : []

            content {
              access_point_id = authorization_config.value.access_point_id
              iam             = authorization_config.value.iam
            }
          }
        }
      }
    }
  }

  dynamic "inference_accelerator" {
    for_each = var.inference_accelerators

    content {
      device_name = inference_accelerator.value.name
      device_type = inference_accelerator.value.type
    }
  }

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration != null ? [true] : []

    content {
      container_name = proxy_configuration.value.container_name
      properties     = proxy_configuration.value.properties
      type           = proxy_configuration.value.type
    }
  }

  tags = var.tags
}

#
# IAM Roles
#
module "iam_role_ecs_exec" {
  count = var.create_execution_role ? 1 : 0

  source  = "geekcell/iam-role/aws"
  version = ">= 1.0.0, < 2.0.0"

  name            = coalesce(var.execution_role_name, "${var.name}-ecs-exec")
  use_name_prefix = var.execution_role_name_prefix

  assume_roles = { "Service" : { identifiers = ["ecs-tasks.amazonaws.com"] } }
  policy_arns  = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

resource "aws_iam_role_policy_attachment" "execute_additional" {
  count = length(var.additional_execute_role_policies)

  role       = module.iam_role_ecs_exec[0].name
  policy_arn = var.additional_execute_role_policies[count.index]
}

module "iam_role_ecs_task" {
  count = var.create_task_role ? 1 : 0

  source  = "geekcell/iam-role/aws"
  version = ">= 1.0.0, < 2.0.0"

  name            = coalesce(var.task_role_name, "${var.name}-ecs-task")
  use_name_prefix = var.task_role_name_prefix

  assume_roles = { "Service" : { identifiers = ["ecs-tasks.amazonaws.com"] } }
}

resource "aws_iam_role_policy_attachment" "task_additional" {
  count = length(var.additional_task_role_policies)

  role       = module.iam_role_ecs_task[0].name
  policy_arn = var.additional_task_role_policies[count.index]
}

resource "aws_iam_role_policy_attachment" "execute_command" {
  count = var.enable_execute_command && var.create_task_role ? 1 : 0

  role       = module.iam_role_ecs_task[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
