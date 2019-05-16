
# Instances variables

variable "availability_zone" {}

variable "subnet_id" {}
variable "subnet_cidr_block" {}

variable "instance_aws_ami" {}

variable "instance_host_n_in_subnet_cidr" {
  default = 100
}

variable "instance_type" {
  default = "t2.micro"
}

variable "n_of_instances" {
  default = 1
}

variable "instance_name" {
  default = "HelloWorldInstance"
}

variable "ssh-private-key" {}
variable "key_pair_name" {}

variable "add_public_ip" {}

variable "vpc_security_group_ids" {
  type = "list"
  default = []
}
