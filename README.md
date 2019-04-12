# TerraformLabsJenkins
Small Terraform Lab for practicing Jenkins

### How to test

First of all update dev/vars.tf file with your own access_key, secret_key and region values.

Make sure to install terraform and ansible and just run the following command on project root.

> bash apply_and_provision.sh dev

This command will build all terraform environment and then try to execute ansible playbook on generated hosts.

In order to destroy created AWS environment just run.

> bash destroy.sh


If you are using Windows 10, You can test it using a WSL like Ubuntu.
Just make sure to anable matadata option so that script can set the proper permissions to ssh key files.

An WSL configuration file example can be found at: scripts/wsl.conf

