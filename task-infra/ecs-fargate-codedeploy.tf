resource "aws_ecs_cluster" "example_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "ALB security group"
  vpc_id      = module.staging.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_lb_to_ecs" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.alb_sg.id 
}

module "basic-example" {
  source                                 = "../terraform-aws-ecs-fargate-codedeploy/"
  name                                   = var.ecs_service_name
  ecs_cluster_name                       = var.ecs_cluster_name
  security_group_ids                     = [aws_security_group.ecs_sg.id]
  lb_arn                                 = aws_lb.alb.arn
  subnet_ids                             = flatten([module.staging.subnet_app_ids])
  load_balancer_container_name           = "nginx"
  load_balancer_container_port           = 80
  target_group_health_check_path         = "/"
  target_group_health_check_matcher      = "200-404"
  lb_listener_certificate_arn            = data.aws_acm_certificate.issued.arn
  lb_listener_port                       = 443
  lb_listener_ssl_policy                 = var.alb_ssl_policy
  lb_listener_protocol                   = "HTTPS"
  create_cloudwatch_log_group            = "true"
  cloudwatch_log_group_name              = var.ecs_cloudwatch_log
  cloudwatch_log_group_retention_in_days = 7

  task_container_definitions = [
    {
      name      = "downloader",
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/awscli:boto3-python", 
      command   = ["bash","-c","/usr/bin/python3 /opt/download.py"]
      essential = false,
      environment = [
        {
          name  = "AWS_REGION",
          value = "${var.aws_region}" # Specify the appropriate region
        },
        {
	  name = "BUCKET_NAME"
          value = var.s3_bucket_html

},
        {
          name  = "HTML_FILE_KEY",
          value = data.aws_ssm_parameter.html_file_key.name
        }
      ],
      mountPoints = [
        {
          sourceVolume  = "html_storage",
          containerPath = "/usr/share/nginx/html",
          readOnly      = false
        }
      ],
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : "${var.ecs_cloudwatch_log}",
          awslogs-region : "${var.aws_region}",
          awslogs-stream-prefix : "downloader"
        }
      }
    },
    {
      name      = "nginx",
      image     = "nginx:latest",
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
        }
      ],
      mountPoints = [
        {
          sourceVolume  = "html_storage",
          containerPath = "/usr/share/nginx/html",
          readOnly      = false
        }
      ],
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : "${var.ecs_cloudwatch_log}",
          awslogs-region : "${var.aws_region}",
          awslogs-stream-prefix : "nginx"
        }
      }
    }
  ]
  task_volumes = [{
    name      = "html_storage"
    host_path = null
    # other volume settings if the module supports them
    "dockerVolumeConfiguration" : {
      "scope" : "task",
      "autoprovision" : true,
      "driver" : "local"
    }
  }]

}


resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecs_task_policy"
  description = "Policy for ECS Tasks to access S3 and SSM"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject"],
        Resource = "arn:aws:s3:::${var.s3_bucket_html}/*"
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::${var.s3_bucket_html}"
      },
      {
        Effect   = "Allow",
        Action   = ["ssm:GetParameter"],
        Resource = "arn:aws:ssm:*:*:parameter${var.ssm_parameter_path}"
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_task_logging_policy" {
  name        = "ecs-task-logging-policy"
  path        = "/"
  description = "Allows ECS tasks to create and push logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow",
        Action   = "logs:CreateLogGroup",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_pull_policy" {
  name        = "ECR-Pull-Policy"
  path        = "/"
  description = "Allows ECS tasks to pull images from a specific ECR repository"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = "arn:aws:ecr:${var.aws_region}:${data.aws_caller_identity.current.account_id}:repository/awscli"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = module.basic-example.task_definition_task_role_name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_logging_policy_attachment" {
  role       = module.basic-example.task_definition_task_role_name
  policy_arn = aws_iam_policy.ecs_task_logging_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_pull_policy_attachment" {
  role       = module.basic-example.task_definition_execution_role_name
  policy_arn = aws_iam_policy.ecr_pull_policy.arn
}
