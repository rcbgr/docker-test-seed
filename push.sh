#!/bin/bash

AWS_ACCOUNT_ID=SET_ME

$(aws ecr get-login --no-include-email --region us-east-1)

docker build -t blog-post-seed .

docker tag blog-post-seed:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/blog-post-seed:latest

docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/blog-post-seed:latest


