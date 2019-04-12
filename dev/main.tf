

provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

module "main_vpc" {
  source = "../modules/vpc"
  avz_names = "${data.aws_availability_zones.azs.names}"
  vpc_name = "${var.main_vpc_name}"
}

module "main_key_pair" {
  source = "../modules/key_pair"

  ssh-key-name = "${var.main_instance_ssh_key_name}"
  ssh-public-key = "${file(var.main_instance_ssh_public_key_path)}"
}

module "open_security_group" {
  source = "../modules/security_group"
  group_name = "OpenSecurityGroup"
  group_description = "Allow All traffic"
  vpc_id = "${module.main_vpc.vpc_id}"
}

module "main_instance" {
  source = "../modules/ec2"

  availability_zone = "${element(data.aws_availability_zones.azs.names, 0)}"
  subnet_id = "${element(module.main_vpc.vpc_subnets_ids, 0)}"
  instance_private_ip = "${var.main_instance_private_ip}"
  add_public_ip = "${var.main_instance_add_public_ip}"

  instance_aws_ami = "${data.aws_ami.ubuntu.id}"

  key_pair_name = "${module.main_key_pair.ssh_key_name}"

  vpc_security_group_id = "${module.open_security_group.security_group_id}"
}

output "main_instance_public_ip" {
  value = "${module.main_instance.instance_public_ip}"
}
