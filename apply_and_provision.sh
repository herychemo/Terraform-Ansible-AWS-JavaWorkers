#!/bin/bash

ENV=$1

if [[ ! -d $ENV ]]; then
    echo "Environment not found, make sure you're running the command on correct directory."
    exit 1;
fi

OLD_WD=$PWD

cd $ENV

echo "Performing Terraform Apply"

terraform init
terraform apply -auto-approve


echo "starting provisioning"

set -e
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    WSL_MSG=$(cat <<-END
    	If you're running inside WSL bash, make sure to mount fs using metadata option
	
	you can just add the contents of file ./scripts/wsl.conf into /etc/wsl.conf 
	
	This will enable using chmod command into ssh keys.

END
    )
    echo $WSL_MSG;
fi

chmod 700 -R ../ssh_keys

if [[ -f ../scripts/terraform.tfstate ]]; then
    rm ../scripts/terraform.tfstate 
fi

cp terraform.tfstate ../scripts/

../scripts/dynamic_inventory.sh --hostfile

export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i ../scripts/dynamic_inventory.sh --private-key ../ssh_keys/tf_main/tf_main ../playbooks/java_server.yml  || echo "\nIt's seems that something went wrong..."

rm ../scripts/terraform.tfstate 



cd $OLD_WD

echo "Done!"
exit 0
