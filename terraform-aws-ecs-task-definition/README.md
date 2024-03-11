<!-- BEGIN_TF_DOCS -->
[![Geek Cell GmbH](https://raw.githubusercontent.com/geekcell/.github/main/geekcell-github-banner.png)](https://www.geekcell.io/)

### Code Quality
[![License](https://img.shields.io/github/license/geekcell/terraform-aws-ecs-task-definition)](https://github.com/geekcell/terraform-aws-ecs-task-definition/blob/master/LICENSE)
[![GitHub release (latest tag)](https://img.shields.io/github/v/release/geekcell/terraform-aws-ecs-task-definition?logo=github&sort=semver)](https://github.com/geekcell/terraform-aws-ecs-task-definition/releases)
[![Release](https://github.com/geekcell/terraform-aws-ecs-task-definition/actions/workflows/release.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-task-definition/actions/workflows/release.yaml)
[![Validate](https://github.com/geekcell/terraform-aws-ecs-task-definition/actions/workflows/validate.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-task-definition/actions/workflows/validate.yaml)
[![Lint](https://github.com/geekcell/terraform-aws-ecs-task-definition/actions/workflows/linter.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-ecs-task-definition/actions/workflows/linter.yaml)

<!--
Comment in if Bridgecrew is configured

### Security
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=INFRASTRUCTURE+SECURITY)

#### Cloud
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+AWS+V1.2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_aws_13)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+AWS+V1.3)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_azure)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+AZURE+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_azure_13)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+AZURE+V1.3)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+GCP+V1.1)

##### Container
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_kubernetes_16)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+KUBERNETES+V1.6)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_eks_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+EKS+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_gke_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+GKE+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/cis_kubernetes)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=CIS+KUBERNETES+V1.5)

#### Data protection
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=SOC2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=PCI-DSS+V3.2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/pci_dss_v321)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=PCI-DSS+V3.2.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=ISO27001)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=NIST-800-53)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=HIPAA)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-ecs-task-definition/fedramp_moderate)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-ecs-task-definition&benchmark=FEDRAMP+%28MODERATE%29)

-->

# Terraform AWS ECS Task Definition Module

Terraform module for creating an AWS ECS Task Definition.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_execute_role_policies"></a> [additional\_execute\_role\_policies](#input\_additional\_execute\_role\_policies) | Additional policy ARNs to attach to the execution role. | `list(string)` | `[]` | no |
| <a name="input_additional_task_role_policies"></a> [additional\_task\_role\_policies](#input\_additional\_task\_role\_policies) | Additional policy ARNs to attach to the task role. | `list(string)` | `[]` | no |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | A list of valid container definitions provided as a valid HCL object list. | `any` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of CPU units used by the task. | `number` | `1024` | no |
| <a name="input_cpu_architecture"></a> [cpu\_architecture](#input\_cpu\_architecture) | CPU architecture required by the task. | `string` | `"X86_64"` | no |
| <a name="input_create_execution_role"></a> [create\_execution\_role](#input\_create\_execution\_role) | If enabled, will create an execution role and attach the AmazonECSTaskExecutionRolePolicy to it. | `bool` | `true` | no |
| <a name="input_create_task_role"></a> [create\_task\_role](#input\_create\_task\_role) | If enabled, will create a task role. | `bool` | `true` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | If enabled, will add the AmazonSSMManagedInstanceCore to the task role. | `bool` | `true` | no |
| <a name="input_ephemeral_storage_size_in_gib"></a> [ephemeral\_storage\_size\_in\_gib](#input\_ephemeral\_storage\_size\_in\_gib) | The amount of ephemeral storage (in GiB) to allocate to the task. | `number` | `20` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | Execution role ARN to attach to the task. | `string` | `null` | no |
| <a name="input_execution_role_name"></a> [execution\_role\_name](#input\_execution\_role\_name) | Name of the execution role to create. | `string` | `null` | no |
| <a name="input_execution_role_name_prefix"></a> [execution\_role\_name\_prefix](#input\_execution\_role\_name\_prefix) | Whether to prefix the execution role name with the family name. | `bool` | `false` | no |
| <a name="input_inference_accelerators"></a> [inference\_accelerators](#input\_inference\_accelerators) | List of Elastic Inference accelerators associated with the task. | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | `[]` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount (in MiB) of memory used by the task. | `number` | `2048` | no |
| <a name="input_name"></a> [name](#input\_name) | Family of the task definition. | `string` | n/a | yes |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The network mode to use for the containers in the task. The valid values are bridge, host, awsvpc, and none. If no network mode is specified, the default is bridge. | `string` | `"awsvpc"` | no |
| <a name="input_operating_system_family"></a> [operating\_system\_family](#input\_operating\_system\_family) | OS family required by the task. | `string` | `"LINUX"` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | Configuration details for an App Mesh proxy. | <pre>object({<br>    container_name = string<br>    properties     = map(any)<br>    type           = optional(string, "APPMESH")<br>  })</pre> | `null` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | The launch type on which to run your service. The valid values are EC2 and FARGATE. | `list(string)` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the created resources. | `map(any)` | `{}` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | Task role ARN to attach to the task. | `string` | `null` | no |
| <a name="input_task_role_name"></a> [task\_role\_name](#input\_task\_role\_name) | Name of the task role to create. | `string` | `null` | no |
| <a name="input_task_role_name_prefix"></a> [task\_role\_name\_prefix](#input\_task\_role\_name\_prefix) | Whether to prefix the task role name with the family name. | `bool` | `false` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A list of volume definitions. | <pre>list(object({<br>    name      = string<br>    host_path = string<br><br>    docker_volume_configuration = optional(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(any)<br>      labels        = map(any)<br>      scope         = string<br>    }))<br><br>    efs_volume_configuration = optional(object({<br>      file_system_id          = string<br>      root_directory          = optional(string)<br>      transit_encryption      = optional(string)<br>      transit_encryption_port = optional(number)<br><br>      authorization_config = optional(object({<br>        access_point_id = string<br>        iam             = optional(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the task definition. |
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | The ARN of the IAM role that grants the Amazon ECS container agent permission to make calls to your Amazon ECS container task. |
| <a name="output_execution_role_name"></a> [execution\_role\_name](#output\_execution\_role\_name) | The name of the IAM role that grants the Amazon ECS container agent permission to make calls to your Amazon ECS container task. |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services. |
| <a name="output_task_role_name"></a> [task\_role\_name](#output\_task\_role\_name) | The name of the IAM role that allows your Amazon ECS container task to make calls to other AWS services. |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.36 |

## Resources

- resource.aws_ecs_task_definition.main (main.tf#6)
- resource.aws_iam_role_policy_attachment.execute_additional (main.tf#113)
- resource.aws_iam_role_policy_attachment.execute_command (main.tf#139)
- resource.aws_iam_role_policy_attachment.task_additional (main.tf#132)
<!-- END_TF_DOCS -->
