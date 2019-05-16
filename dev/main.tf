

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
  subnet_cidr_block = "${element(module.main_vpc.vpc_subnets_cidrs, 0)}"

  add_public_ip = "${var.main_instance_add_public_ip}"

  instance_name = "${var.main_instances_name}"
  instance_host_n_in_subnet_cidr = "${var.main_instances_host_n_in_subnet_cidr}"
  n_of_instances = "${var.main_instances_n_of_instances}"

  instance_aws_ami = "${data.aws_ami.ubuntu.id}"

  key_pair_name = "${module.main_key_pair.ssh_key_name}"
  ssh-private-key = "${file(var.main_instance_ssh_private_key_path)}"

  vpc_security_group_ids = "${list(module.open_security_group.security_group_id)}"
}


module "main_load_balancer" {
  source = "../modules/load_balancer"

  load_balancer_name = "${var.main_load_balancer_name}"
  instance_ids = "${module.main_instance.instance_ids}"
  health_check_pattern = "${var.main_lb_health_check_pattern}"

  vpc_security_group_ids = "${list(module.open_security_group.security_group_id)}"
  subnet_ids = "${list(element(module.main_vpc.vpc_subnets_ids, 0), element(module.main_vpc.vpc_subnets_ids, 1))}"

}


output "main_instances_public_ips" {
  value = "${module.main_instance.instance_public_ips}"
}

output "main_load_balancer_dns" {
  value = "${module.main_load_balancer.public_access}"
}
