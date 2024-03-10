resource "aws_iam_role" "codebuild_role" {
  name = "CodeBuildRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Effect = "Allow",
    }]
  })
}

resource "aws_iam_policy" "codebuild_policy" {
  name = "CodeBuildPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.html_files.id}/*",
          "arn:aws:s3:::${aws_s3_bucket.html_files.id}"
        ]
      },
      {
        Effect   = "Allow",
        Action   = "ssm:PutParameter",
        Resource = "arn:aws:ssm:*:*:parameter${var.ssm_parameter_path}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

resource "aws_iam_policy" "codebuild_cloudwatch_logs_policy" {
  name        = "CodeBuildCloudWatchLogsPolicy"
  description = "Allow CodeBuild to create and put log streams in CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/codaproject",
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/codaproject:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_cloudwatch_logs_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_cloudwatch_logs_policy.arn
}


resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
    }]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  role = aws_iam_role.codepipeline_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:StopBuild",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = ["arn:aws:s3:::${var.s3_codepipeline_artifact}/*",aws_codebuild_project.coda_project.arn]
      }
    ]
  })
}

resource "aws_iam_policy" "codestar_connections_policy" {
  name        = "CodeStarConnectionsPolicy"
  description = "Allow use of CodeStar Connections"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [{
      Effect : "Allow",
      Action : "codestar-connections:UseConnection",
      Resource : var.codepipeline_connection_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codestar_connections_attach" {
  role       = aws_iam_role.codepipeline_role.name # Replace with your role's name
  policy_arn = aws_iam_policy.codestar_connections_policy.arn
}

resource "aws_iam_policy" "codebuild_s3_access" {
  name        = "CodeBuildS3Access"
  description = "Allow CodeBuild to access artifacts in S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion"
        ],
        Resource = "arn:aws:s3:::${var.s3_codepipeline_artifact}/coda-pipeline/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_s3_access_attach" {
  role       = aws_iam_role.codebuild_role.name # Replace with your CodeBuild role's name
  policy_arn = aws_iam_policy.codebuild_s3_access.arn
}

resource "aws_iam_policy" "codedeploy_s3_access" {
  name        = "CodeDeployS3Access"
  description = "Allow CodeDeploy to access artifacts in S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.s3_codepipeline_artifact}",
          "arn:aws:s3:::${var.s3_codepipeline_artifact}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_s3_access_attach" {
  role       = var.codedeploy_role_name
  policy_arn = aws_iam_policy.codedeploy_s3_access.arn
}

resource "aws_iam_policy" "codepipeline_codedeploy_policy" {
  name        = "CodePipelineCodeDeployPolicy"
  description = "Policy granting CodePipeline access to CodeDeploy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codedeploy:CreateDeployment",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:GetDeploymentGroup",
          "codedeploy:ListApplications",
          "codedeploy:ListDeploymentGroups",
          "codedeploy:ListDeploymentConfigs"
        ],
        Resource = [
          "arn:aws:codedeploy:${var.aws_region}:${data.aws_caller_identity.current.account_id}:application:${var.codedeploy_deployment_app_name}",
          "arn:aws:codedeploy:${var.aws_region}:${data.aws_caller_identity.current.account_id}:deploymentgroup:${var.codedeploy_deployment_app_name}/${var.codedeploy_deployment_group_name}"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_codedeploy_attach" {
  role       = aws_iam_role.codepipeline_role.name # Make sure this matches the exact name of your CodePipeline IAM role
  policy_arn = aws_iam_policy.codepipeline_codedeploy_policy.arn
}

