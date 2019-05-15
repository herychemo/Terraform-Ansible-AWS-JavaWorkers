#!/bin/bash

ENV=$1

if [[ ! -d $ENV ]]; then
    echo "Environment not found, make sure you're running the command on correct directory."
    exit 1;
fi

OLD_WD=$PWD

cd $ENV

echo && echo "Performing Terraform Apply"

# Make sure terraform is initialized
terraform init

# Perform Terraform apply operation twice in order to make sure EIP is updated in TfState File
terraform apply -auto-approve
terraform apply -auto-approve


echo && echo "Adding SSH Keys to Known Hosts"

MAIN_INSTANCES_IPS=`terraform output main_instances_public_ips`
MAIN_INSTANCES_IPS=`echo $MAIN_INSTANCES_IPS | sed 's/,//g'`
for IP in $MAIN_INSTANCES_IPS; do
    ssh-keygen -R $IP
    ssh-keyscan -H $IP >> ~/.ssh/known_hosts
done


echo && echo "Starting Provisioning"

set -e
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    WSL_MSG=$(cat << END
If you're running inside WSL bash, make sure to mount fs using metadata option
you can just add the contents of file ./scripts/wsl.conf into /etc/wsl.conf
This will enable using chmod command into ssh keys.

END
    )
    echo "${WSL_MSG}" && echo
fi

chmod 700 -R ../ssh_keys

if [[ -f ../scripts/terraform.tfstate ]]; then
    rm ../scripts/terraform.tfstate 
fi

cp terraform.tfstate ../scripts/

bash ../scripts/dynamic_inventory.sh --hostfile

#If you can't add hosts to known hosts file, uncomment next line.
#export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i ../scripts/dynamic_inventory.sh \
    --private-key ../ssh_keys/tf_main/tf_main \
    ../ansible/playbook.yml \
        || echo "\nIt's seems that something went wrong..."


rm ../scripts/terraform.tfstate 


echo && echo "Terraform Outputs:"
terraform output -json



cd $OLD_WD

echo && echo "Done!"
exit 0
