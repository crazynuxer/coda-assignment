module "basic-example" {
  source = "../../"

  name = var.name

  assume_roles = {
    AWS : {
      identifiers : [var.account]
    }
  }

  policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}
