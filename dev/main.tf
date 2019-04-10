

provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

module "my_vpc" {
  source = "../modules/vpc"
  avz_names = "${data.aws_availability_zones.azs.names}"
}

module "my_instance" {
  source = "../modules/ec2"

  availability_zone = "${element(data.aws_availability_zones.azs.names, 0)}"
  instance_private_ip = "192.168.0.100"

  subnet_id = "${element(module.my_vpc.vpc_subnets_ids, 0)}"

  instance_aws_ami = "${data.aws_ami.ubuntu.id}"
}

