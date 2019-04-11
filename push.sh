#!/bin/bash

AWS_ACCOUNT_ID=SET_ME

$(aws ecr get-login --no-include-email --region us-east-1)

docker build -t docker-test-seed .

docker tag docker-test-seed:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/docker-test-seed:latest

docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/docker-test-seed:latest


