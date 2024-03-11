/**
 * # Terraform AWS IAM Role
 *
 * Introducing the AWS IAM Role Terraform Module, a highly efficient solution for creating and managing your AWS
 * Identity and Access Management (IAM) roles. This module has been expertly crafted to provide you with a simple and
 * streamlined way to create and manage your IAM roles within AWS.
 *
 * Our team of experts has years of experience working with AWS IAM and has a deep understanding of the best practices
 * and configurations. By using this Terraform module, you can be sure that your IAM roles are created and managed in
 * a secure, efficient, and scalable manner.
 *
 * This module offers a preconfigured solution for creating IAM roles, saving you time and effort in the process.
 * Whether you're looking to grant access to specific AWS services or to limit the actions that can be performed on
 * your resources, this module has you covered.
 *
 * So, if you're looking for a convenient and reliable solution for creating and managing your IAM roles within AWS,
 * look no further than the AWS IAM Role Terraform Module. Give it a try and see the difference it can make in your
 * AWS setup!
 */
data "aws_iam_policy_document" "assume" {
  for_each = var.assume_roles

  statement {
    effect  = "Allow"
    actions = coalesce(each.value.actions, ["sts:AssumeRole"])

    principals {
      type        = each.key
      identifiers = each.value.identifiers
    }

    dynamic "condition" {
      for_each = {
        for cond in coalesce(each.value.conditions, []) :
        "${cond.variable}-${cond.test}" => cond
      }

      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_combined" {
  # Merge all passed assume_role documents into one
  override_policy_documents = concat(
    [for policy in data.aws_iam_policy_document.assume : policy.json],
    var.assume_role_json == null ? [] : [var.assume_role_json]
  )
}

resource "aws_iam_role" "main" {
  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? var.name : null
  description = var.description

  path                 = var.path
  max_session_duration = var.max_session_duration

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.permissions_boundary
  assume_role_policy    = data.aws_iam_policy_document.assume_combined.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "main" {
  count = length(var.policy_arns)

  role       = aws_iam_role.main.name
  policy_arn = var.policy_arns[count.index]
}

resource "aws_iam_instance_profile" "main" {
  count = var.enable_iam_instance_profile ? 1 : 0

  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? var.name : null
  role        = aws_iam_role.main.id
  path        = var.path

  tags = var.tags
}
