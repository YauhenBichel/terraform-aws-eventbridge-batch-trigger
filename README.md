# Terraform AWS EventBridge Trigger for AWS Batch

[![Terraform Registry](https://img.shields.io/badge/Terraform-Registry-7B42BC?logo=terraform&logoColor=white)](https://registry.terraform.io/modules/YauhenBichel/eventbridge-batch-trigger/aws/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Creates EventBridge rules that trigger an AWS Batch job on a schedule. Supports a main cron schedule and an optional separate hourly rule, so a job can run nightly and hourly from the same module.

## Usage

```hcl
module "batch_trigger" {
  source  = "YauhenBichel/eventbridge-batch-trigger/aws"
  version = "1.1.0"

  env                        = "prod"
  service_domain             = "payments"
  team                       = "infra-team"
  aws_region                 = "eu-west-1"

  eventbridge_rule_name      = "nightly-recon-trigger"
  aws_batch_job_name         = "nightly-reconciliation"
  aws_batch_job_revision_arn = module.batch_job_revision.job_definition_arn
  execution_role_arn         = aws_iam_role.batch_execution.arn
  job_queue_arn              = aws_batch_job_queue.main.arn

  schedule_expression        = "cron(0 2 * * ? *)"   # 02:00 daily
  eventbridge_rule_enabled   = true
}
```

Without `eventbridge_rule_enabled = true` the rule is created in the `DISABLED`
state and never fires. The flag defaults to `false` so that a rule can be
declared before it is meant to run.

## Provider configuration

This module does not declare its own `provider` block — the caller supplies it. That keeps the
module usable with `count`, `for_each` and `depends_on`, which Terraform forbids for modules
carrying their own provider configuration.

Configure the AWS provider in your root module, and use `default_tags` there if you want tags
applied across every resource:

```hcl
provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Admin-Environment   = "prod"
      Admin-ServiceDomain = "payments"
      Team                = "infra-team"
    }
  }
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws provider | ~> 6.0 |

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `env` | `string` | — | Environment being deployed to |
| `service_domain` | `string` | — | Namespaces deployments in a shared account |
| `team` | `string` | `infra-team` | Owning team |
| `aws_region` | `string` | `eu-west-1` | Target region |
| `eventbridge_rule_name` | `string` | — | Name of the EventBridge rule |
| `eventbridge_hourly_rule_name` | `string` | `""` | Name of the optional hourly rule |
| `schedule_expression` | `string` | `null` | Cron expression for the main rule |
| `schedule_expression_hourly` | `string` | `null` | Cron expression for the hourly rule |
| `aws_batch_job_name` | `string` | — | Batch job name to invoke |
| `aws_batch_job_name_hourly` | `string` | `""` | Batch job name for the hourly rule. Only read when `schedule_expression_hourly` is set |
| `aws_batch_job_revision_arn` | `string` | — | ARN of the job definition revision |
| `execution_role_arn` | `string` | — | Execution role ARN |
| `job_queue_arn` | `string` | — | ARN of the Batch job queue the rule targets |
| `eventbridge_rule_enabled` | `bool` | `false` | `true` creates the main rule `ENABLED`; otherwise `DISABLED` |
| `eventbridge_rule_hourly_enabled` | `bool` | `false` | Same, for the hourly rule |

A dash in the Default column means the input is required.

## Outputs

| Name | Description |
|---|---|
| `main_eventbridge_rule_arn` | ARN of the main rule, `null` if not created |
| `hourly_eventbridge_rule_arn` | ARN of the hourly rule, `null` if not created |
| `main_eventbridge_rule_name` | Name of the main rule |
| `hourly_eventbridge_rule_name` | Name of the hourly rule |
| `main_eventbridge_rule_state` | State of the main rule |
| `hourly_eventbridge_rule_state` | State of the hourly rule |
| `event_target` | The main rule's Batch target |
| `hourly_event_target` | The hourly rule's Batch target |

## Contributing

Issues and pull requests are welcome. Please open an issue describing the problem before
sending a large change.

## Licence

[MIT](LICENSE) — Yauhen Bichel

---

## Contributors

Thank you to everyone who has helped.

<!-- readme: contributors,bots/- -start -->
<!-- readme: contributors,bots/- -end -->

Filled from GitHub commits (bots omitted). Live demo: [readme-contributors](https://github.com/YauhenBichel/readme-contributors#live-demo).
