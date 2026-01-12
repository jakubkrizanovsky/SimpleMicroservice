#!/bin/bash

# read env variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# cleanup infrastructure
cd terraform
terraform destroy --auto-approve

# remove ansible hosts file
cd ..
rm ansible/inventories/dev/hosts 