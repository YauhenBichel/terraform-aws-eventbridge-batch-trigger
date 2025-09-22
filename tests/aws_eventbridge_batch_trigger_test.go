package test

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEventBridgeRuleWithSchedule(t *testing.T) {
	tempDir := t.TempDir()
	planFilePath := filepath.Join(tempDir, "terraform.tfplan")

	terraformOptions := &terraform.Options{
		TerraformBinary: "terraform",
		TerraformDir:    "../",
		PlanFilePath:    planFilePath,
		Vars: map[string]interface{}{
			"aws_region":                   "us-east-1",
			"env":                          "local",
			"team":                         "test-team",
			"service_domain":               "test-domain",
			"aws_batch_job_revision_arn":   "arn:aws:batch:us-west-2:123456789012:job-definition/local-job-definition:1",
			"eventbridge_rule_name":        "test-batch-trigger-rule",
			"eventbridge_hourly_rule_name": "test-batch-hourly-trigger-rule",
			"schedule_expression":          "rate(5 minutes)",
			"schedule_expression_hourly":   "rate(1 hour)",
		},
	}

	planOutput := terraform.InitAndPlan(t, terraformOptions)

	assert.Contains(t, planOutput, "test-batch-trigger-rule")
	assert.Contains(t, planOutput, "test-batch-hourly-trigger-rule")
	assert.Contains(t, planOutput, "rate(5 minutes)")
	assert.Contains(t, planOutput, "rate(1 hour)")

	assert.Contains(t, planOutput, "local")
	assert.Contains(t, planOutput, "test-team")
	assert.Contains(t, planOutput, "test-domain")
}
