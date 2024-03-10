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
        Resource = "arn:aws:ssm:*:*:parameter/webserver/html_file_key"
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
          "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/codaproject",
          "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/codaproject:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_cloudwatch_logs_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_cloudwatch_logs_policy.arn
}

