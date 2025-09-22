terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_cloudwatch_event_rule" "trigger" {
  count = var.schedule_expression == null ? 0 : 1

  name = var.eventbridge_rule_name
  description = "Schedule running of AWS Batch Job by CloudWatch"
  schedule_expression = var.schedule_expression
  state = var.eventbridge_rule_enabled ? "ENABLED" : "DISABLED"

  tags = merge(
    {
      ManagedBy = "Terraform"
      RuleType  = "main"
    }
  )
}

resource "aws_cloudwatch_event_rule" "hourly_trigger" {
  count = var.schedule_expression_hourly == null ? 0 : 1

  name = var.eventbridge_hourly_rule_name
  description = "Hourly Schedule running of AWS Batch Job by CloudWatch"
  schedule_expression = var.schedule_expression_hourly
  state = var.eventbridge_rule_hourly_enabled ? "ENABLED" : "DISABLED"

  tags = merge(
    {
      ManagedBy = "Terraform"
      RuleType  = "hourly"
    }
  )
}

resource "aws_cloudwatch_event_target" "event_target" {
  count = var.schedule_expression == null ? 0 : 1

  rule      = aws_cloudwatch_event_rule.trigger[0].name
  arn       = var.job_queue_arn
  role_arn  = var.execution_role_arn

  batch_target {
    job_definition = var.aws_batch_job_revision_arn
    job_name = var.aws_batch_job_name
  }
}

resource "aws_cloudwatch_event_target" "hourly_event_target" {
  count = var.schedule_expression_hourly == null ? 0 : 1
  
  rule      = aws_cloudwatch_event_rule.hourly_trigger[0].name
  arn       = var.job_queue_arn
  role_arn  = var.execution_role_arn

  batch_target {
    job_definition = var.aws_batch_job_revision_arn
    job_name = var.aws_batch_job_name_hourly
  }
}