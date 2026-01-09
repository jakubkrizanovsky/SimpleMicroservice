#!/bin/bash

cd terraform
terraform destroy --auto-approve

cd ..
rm ansible/inventories/dev/hosts 