resource "aws_codebuild_project" "coda_project" {
  name         = "codaproject"
  description  = "Build project triggered by GitHub tag"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "S3_BUCKET"
      value = var.s3_bucket_html
    }

    environment_variable {
      name  = "SSM_PATH"
      value = var.ssm_parameter_path
    }
  }

  source {
    type                = "GITHUB"
    location            = "https://github.com/crazynuxer/coda-assignment.git"
    git_clone_depth     = 1
    buildspec           = "buildspec.yaml"
    report_build_status = true
  }

}

