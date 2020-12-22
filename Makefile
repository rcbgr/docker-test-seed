
PROFILE ?= test

ACCOUNT_ID := $(shell aws sts get-caller-identity --profile $(PROFILE) --query 'Account' --output text)

.PHONY: push
push:
	@$(aws ecr get-login --profile $(PROFILE) --no-include-email --region us-east-1)
	@docker build -t docker-test-seed .
	@docker tag docker-test-seed:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/docker-test-seed:latest
	@docker push $(ACCOUNT_ID).dkr.ecr.us-east-1.amazonaws.com/docker-test-seed:latest

.PHONY: public
public:
	@(aws ecr-public get-login-password --profile $(PROFILE) --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/q5l2x5i4)
	@docker build -t aws-builder-tools-workshop .
	@docker tag aws-builder-tools-workshop:latest public.ecr.aws/q5l2x5i4/aws-builder-tools-workshop:latest
	@docker push public.ecr.aws/q5l2x5i4/aws-builder-tools-workshop:latest
