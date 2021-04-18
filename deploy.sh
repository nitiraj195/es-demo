#!/usr/bin/env bash

set -eou pipefail

terraform init
terraform apply -var-file="./envs/elasticsearch.tfvars"

echo "copying config files"

cp -r config /tmp/

sleep 5;

echo "Instances are getting ready"

sleep 15;

ansible-playbook -i lib/terraform.py playbooks/elasticsearch.yaml
