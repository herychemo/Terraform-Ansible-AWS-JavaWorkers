#!/bin/bash

ENV=$1

if [[ ! -d $ENV ]]; then
    echo "Environment not found, make sure you're running the command on correct directory."
    exit 1;
fi

OLD_WD=$PWD

cd $ENV

echo "destroying..."
terraform destroy -auto-approve

if [[ -f ../scripts/terraform.tfstate ]]; then
    rm ../scripts/terraform.tfstate 
fi



cd $OLD_WD

echo "Done!"
exit 0

