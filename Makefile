project = punkerside
service = jenkins

export AWS_DEFAULT_REGION=us-east-1
export DOCKER_BUILDKIT=0

# creating vpc
vpc:
	@cd terraform/vpc/ && terraform init
	@cd terraform/vpc/ && terraform apply -var="name=${project}-${service}" -auto-approve

# provisioning ami for jenkins
ami:
	@packer init config.pkr.hcl
	@packer build -var "name=${project}-${service}" config.pkr.hcl

# destroy all infrastructure
destroy:
	@cd terraform/vpc/ && terraform destroy -var="name=${project}-${service}" -auto-approve