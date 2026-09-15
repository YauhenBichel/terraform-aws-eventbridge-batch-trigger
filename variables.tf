variable "env" {
  description = "The environment being deployed to"
  type        = string
  nullable    = false
}

variable "service_domain" {
  description = "Used to help create namespaced deployments in case of shared account."
  type = string
  nullable = false
}

variable "team" {
  default     = "infra-team"
  description = "Team"
  type = string
  nullable = false
}

variable "aws_region" {
  default     = "eu-west-1"
  description = "Where this will be deployed to"
  type = string
  nullable = false
}

# AWS EventBridge Batch Trigger

variable "eventbridge_rule_name" {
    description = "Name of the EventBridge rule with target AWS Batch Job"
    type = string
}

variable "eventbridge_hourly_rule_name" {
  description = "Rule name for hourly triggering"
  type = string
  default = ""
}

variable "execution_role_arn" {
  description = "Execution role ARN for the batch job"
  type        = string
}

variable "schedule_expression" {
  default     = null
  description = "The cron-esque expression to optionally trigger the AWS Batch Job on a schedule"
  type        = string
}

variable "schedule_expression_hourly" {
  default     = null
  description = "The cron-esque expression to optionally trigger the AWS Batch Job on a schedule hourly"
  type        = string
}

variable "aws_batch_job_name" {
  description = "AWS Batch Job name"
  type = string
}

variable "aws_batch_job_name_hourly" {
  default     = ""
  description = "AWS Batch Job Hourly name"
  type = string
}

variable "aws_batch_job_revision_arn" {
  description = "ARN of new revision"
  type = string
}

variable "job_queue_arn" {
  description = "ARN of job queue"
  type = string
}

variable "eventbridge_rule_enabled" {
  description = "Whether to enable the EventBridge rules (default: false for safety)"
  type        = bool
  default     = false
}

variable "eventbridge_rule_hourly_enabled" {
  description = "Whether to enable the EventBridge rules (default: false for safety)"
  type        = bool
  default     = false
}