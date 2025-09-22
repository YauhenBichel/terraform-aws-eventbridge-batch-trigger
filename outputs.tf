output "main_eventbridge_rule_arn" {
  description = "ARN of the main EventBridge rule"
  value       = length(aws_cloudwatch_event_rule.trigger) > 0 ? aws_cloudwatch_event_rule.trigger[0].arn : null
}

output "hourly_eventbridge_rule_arn" {
  description = "ARN of the hourly EventBridge rule"
  value       = length(aws_cloudwatch_event_rule.hourly_trigger) > 0 ? aws_cloudwatch_event_rule.hourly_trigger[0].arn : null
}

output "main_eventbridge_rule_name" {
  description = "Name of the main EventBridge rule"
  value       = length(aws_cloudwatch_event_rule.trigger) > 0 ? aws_cloudwatch_event_rule.trigger[0].name : null
}

output "hourly_eventbridge_rule_name" {
  description = "Name of the hourly EventBridge rule"
  value       = length(aws_cloudwatch_event_rule.hourly_trigger) > 0 ? aws_cloudwatch_event_rule.hourly_trigger[0].name : null
}

output "main_eventbridge_rule_state" {
  description = "Current state of the main EventBridge rule (ENABLED/DISABLED)"
  value       = length(aws_cloudwatch_event_rule.trigger) > 0 ? aws_cloudwatch_event_rule.trigger[0].state : null
}

output "hourly_eventbridge_rule_state" {
  description = "Current state of the hourly EventBridge rule (ENABLED/DISABLED)"
  value       = length(aws_cloudwatch_event_rule.hourly_trigger) > 0 ? aws_cloudwatch_event_rule.hourly_trigger[0].state : null
}

output "event_target" {
  description = "ARN of the main EventBridge target"
  value       = length(aws_cloudwatch_event_target.event_target) > 0 ? aws_cloudwatch_event_target.event_target[0].arn : null
}

output "hourly_event_target" {
  description = "ARN of the hourly EventBridge target"
  value       = length(aws_cloudwatch_event_target.hourly_event_target) > 0 ? aws_cloudwatch_event_target.hourly_event_target[0].arn : null
}