## NAMING
variable "name" {
  description = "Name or prefix of the Role."
  type        = string
}

variable "description" {
  description = "Description of the Role."
  default     = null
  type        = string
}

variable "tags" {
  description = "Tags to add to the Role."
  default     = {}
  type        = map(any)
}

## AWS IAM Policy
variable "use_name_prefix" {
  description = "Use the `name` attribute as prefix for the role name."
  default     = true
  type        = bool
}

variable "assume_roles" {
  description = "A map of principals which can assume the role. The default action is: `[\"sts:AssumeRole\"]`"
  default     = {}
  type = map(object({
    actions     = optional(list(string))
    identifiers = list(string)

    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })))
  }))
}

variable "assume_role_json" {
  description = "A rendered JSON string of the `assume_roles` variable."
  default     = null
  type        = string
}

variable "policy_arns" {
  description = "A list of policy ARNs to attach to the role."
  default     = []
  type        = list(string)
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the specified role."
  default     = 3600
  type        = number
}

variable "path" {
  description = "Path to the role."
  default     = "/"
  type        = string
}

variable "force_detach_policies" {
  description = "Whether to force detaching any policies the role has before destroying it."
  default     = false
  type        = bool
}

variable "permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the role."
  default     = null
  type        = string
}

variable "enable_iam_instance_profile" {
  description = "If enabled, will create an IAM instance profile for this role."
  default     = false
  type        = bool
}
