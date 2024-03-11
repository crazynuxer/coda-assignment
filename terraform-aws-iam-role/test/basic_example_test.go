package test

import (
	"encoding/json"
	"fmt"
	"net/url"
	"os"
	"testing"

	TTAWS "github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/stretchr/testify/assert"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/iam"
)

type AWSPrincipal struct {
	AWS string `json:"AWS"`
}

type Statement struct {
	Sid       string       `json:"Sid"`
	Effect    string       `json:"Effect"`
	Principal AWSPrincipal `json:"Principal"`
	Action    string       `json:"Action"`
}

type Policy struct {
	Version   string      `json:"Version"`
	Statement []Statement `json:"Statement"`
}

func TestTerraformBasicExample(t *testing.T) {
	roleName := "terraform-test-iam-role-" + GetShortId()
	accountId := os.Getenv("AWS_TESTING_ACCOUNT_ID")
	account := fmt.Sprintf("arn:aws:iam::%s:root", accountId)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/basic-example",
		Vars: map[string]interface{}{
			"name":    roleName,
			"account": account,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	name := terraform.Output(t, terraformOptions, "name")
	assert.NotEmpty(t, name)

	arn := terraform.Output(t, terraformOptions, "arn")
	assert.NotEmpty(t, arn)

	sess, err := NewSession(os.Getenv("AWS_REGION"))
	assert.NoError(t, err)

	client := iam.New(sess)

	input := iam.ListRolesInput{}
	output, err := client.ListRoles(&input)
	assert.NoError(t, err)

	role := FilterRoles(t, name, output.Roles)

	assert.Equal(t, "/", aws.StringValue(role.Path))

	decodedValue, err := url.QueryUnescape(aws.StringValue(role.AssumeRolePolicyDocument))
	assert.NoError(t, err)

	var policy Policy
	err = json.Unmarshal([]byte(decodedValue), &policy)
	assert.NoError(t, err)

	assert.Equal(t, "2012-10-17", policy.Version)

	assert.Equal(t, 1, len(policy.Statement))
	assert.Equal(t, "", policy.Statement[0].Sid)
	assert.Equal(t, "Allow", policy.Statement[0].Effect)
	assert.Equal(t, "sts:AssumeRole", policy.Statement[0].Action)
	assert.Equal(t, account, policy.Statement[0].Principal.AWS)
}

func FilterRoles(t *testing.T, name string, roles []*iam.Role) *iam.Role {
	for _, role := range roles {
		if aws.StringValue(role.RoleName) == name {
			return role
		}
	}

	t.Fatalf("Could not file role %s", name)

	return nil
}

func NewSession(region string) (*session.Session, error) {
	sess, err := TTAWS.NewAuthenticatedSession(region)
	if err != nil {
		return nil, err
	}

	return sess, nil
}

func GetShortId() string {
	githubSha := os.Getenv("GITHUB_SHA")
	if len(githubSha) >= 7 {
		return githubSha[0:6]
	}

	return "local"
}
