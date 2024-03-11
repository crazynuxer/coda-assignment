## NAMING
variable "name" {
  description = "Family of the task definition."
  type        = string
}

variable "tags" {
  description = "Tags to add to the created resources."
  default     = {}
  type        = map(any)
}

## TASK DEFINITION
variable "network_mode" {
  description = "The network mode to use for the containers in the task. The valid values are bridge, host, awsvpc, and none. If no network mode is specified, the default is bridge."
  default     = "awsvpc"
  type        = string
}

variable "requires_compatibilities" {
  description = "The launch type on which to run your service. The valid values are EC2 and FARGATE."
  default     = ["FARGATE"]
  type        = list(string)
}

variable "execution_role_arn" {
  description = "Execution role ARN to attach to the task."
  default     = null
  type        = string
}
variable "task_role_arn" {
  description = "Task role ARN to attach to the task."
  default     = null
  type        = string
}

variable "container_definitions" {
  description = "A list of valid container definitions provided as a valid HCL object list."
  type        = any
}

variable "memory" {
  description = "Amount (in MiB) of memory used by the task."
  default     = 2048
  type        = number
}

variable "cpu" {
  description = "Number of CPU units used by the task."
  default     = 1024
  type        = number
}

variable "operating_system_family" {
  description = "OS family required by the task."
  default     = "LINUX"
  type        = string

  validation {
    condition = contains([
      "LINUX", "WINDOWS_SERVER_2019_FULL", "WINDOWS_SERVER_2019_CORE", "WINDOWS_SERVER_2022_FULL",
      "WINDOWS_SERVER_2022_CORE"
    ], var.operating_system_family)
    error_message = "Value must be `X86_64` or `ARM64`."
  }
}

variable "cpu_architecture" {
  description = "CPU architecture required by the task."
  default     = "X86_64"
  type        = string

  validation {
    condition     = contains(["X86_64", "ARM64"], var.cpu_architecture)
    error_message = "Value must be `X86_64` or `ARM64`."
  }
}

variable "ephemeral_storage_size_in_gib" {
  description = "The amount of ephemeral storage (in GiB) to allocate to the task."
  default     = 20
  type        = number

  validation {
    condition     = var.ephemeral_storage_size_in_gib >= 20 && var.ephemeral_storage_size_in_gib <= 200
    error_message = "Value must be between 20 and 200."
  }
}

variable "volumes" {
  description = "A list of volume definitions."
  default     = []
  type = list(object({
    name      = string
    #host_path = string
    host_path = optional(string)  # Make host_path optional

    docker_volume_configuration = optional(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(any)
      labels        = map(any)
      scope         = string
    }))

    efs_volume_configuration = optional(object({
      file_system_id          = string
      root_directory          = optional(string)
      transit_encryption      = optional(string)
      transit_encryption_port = optional(number)

      authorization_config = optional(object({
        access_point_id = string
        iam             = optional(string)
      }))
    }))
  }))
}

variable "inference_accelerators" {
  description = "List of Elastic Inference accelerators associated with the task."
  default     = []
  type = list(object({
    name = string
    type = string
  }))
}

variable "proxy_configuration" {
  description = "Configuration details for an App Mesh proxy."
  default     = null
  type = object({
    container_name = string
    properties     = map(any)
    type           = optional(string, "APPMESH")
  })
}

## IAM ROLES
variable "create_execution_role" {
  description = "If enabled, will create an execution role and attach the AmazonECSTaskExecutionRolePolicy to it."
  default     = true
  type        = bool
}

variable "execution_role_name" {
  description = "Name of the execution role to create."
  default     = null
  type        = string
}

variable "execution_role_name_prefix" {
  description = "Whether to prefix the execution role name with the family name."
  default     = false
  type        = bool
}

variable "create_task_role" {
  description = "If enabled, will create a task role."
  default     = true
  type        = bool
}

variable "task_role_name" {
  description = "Name of the task role to create."
  default     = null
  type        = string
}

variable "task_role_name_prefix" {
  description = "Whether to prefix the task role name with the family name."
  default     = false
  type        = bool
}

variable "additional_execute_role_policies" {
  description = "Additional policy ARNs to attach to the execution role."
  default     = []
  type        = list(string)
}

variable "additional_task_role_policies" {
  description = "Additional policy ARNs to attach to the task role."
  default     = []
  type        = list(string)
}

variable "enable_execute_command" {
  description = "If enabled, will add the AmazonSSMManagedInstanceCore to the task role."
  default     = true
  type        = bool
}
