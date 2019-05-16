#!/bin/bash

ENV=$1

if [[ ! -d $ENV ]]; then
    echo "Environment not found, make sure you're running the command on correct directory."
    exit 1;
fi

OLD_WD=$PWD

cd $ENV

echo "destroying..."

# Make sure terraform is initialized
terraform init

# Destroy all resources created by terraform
terraform destroy -auto-approve


cd $OLD_WD

echo "Done!"
exit 0
