# Terraform module for triggering AWS Batch Job using AWS EventBridge rules

## Author is Yauhen Bichel

## How to use 

```

module "aws_eventbridge_batch_trigger" {
  source                       = "./modules/aws_eventbridge_batch_trigger"

  aws_region                   = var.aws_region
  env                          = var.env
  team                         = var.team
  service_domain               = var.service_domain
  
  execution_role_arn           = var.aws_batch_job_revision_execution_role_arn
  job_queue_arn                = data.aws_batch_job_queue.existing_queue.arn
  aws_batch_job_name           = local.aws_batch_job_name
  aws_batch_job_name_hourly    = local.aws_batch_job_name_hourly
  aws_batch_job_revision_arn   = module.aws_batch_job_revision.job_definition_arn
  eventbridge_rule_name        = var.eventbridge_rule_name
  eventbridge_hourly_rule_name = var.eventbridge_hourly_rule_name
  schedule_expression          = var.eventbridge_batch_job_schedule_expression
  schedule_expression_hourly   = var.eventbridge_batch_job_schedule_hourly_expression

  eventbridge_rule_enabled     = var.eventbridge_rule_enabled
  eventbridge_rule_hourly_enabled = var.eventbridge_rule_hourly_enabled
}

```

## Terratest Tests

>go mod init batch-job-definition-tests

>go get github.com/gruntwork-io/terratest

>go get github.com/stretchr/testify

>go mod tidy

>go test -v