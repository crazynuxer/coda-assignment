resource "aws_ssm_parameter" "html_file_key" {
  name  = var.ssm_parameter_path
  type  = "String"
  value = "sample.html" # Specify the key of your HTML file stored in the S3 bucket
  lifecycle {
    ignore_changes = [
      value, # Ignore changes to the value after creation
    ]
  }
}
