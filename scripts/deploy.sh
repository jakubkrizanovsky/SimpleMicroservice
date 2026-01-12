#!/bin/bash

# read env variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# prepare node using terraform
cd terraform
terraform init
terraform apply --auto-approve

# copy inventory file to ansible inventory
cd ..
mkdir -p ansible/inventories/dev
cp terraform/outputs/hosts ansible/inventories/dev/hosts

# provision node using ansible
cd ansible
ansible-playbook site.yml -i inventories/dev/
