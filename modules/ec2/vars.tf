
# Instances variables

variable "availability_zone" {}

variable "subnet_id" {}

variable "instance_aws_ami" {}

variable "instance_private_ip" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "HelloWorldInstance"
}

variable "key_pair_name" {
  default = ""
}

variable "add_public_ip" {}

variable "vpc_security_group_id" {
  //type = "list"
  default = ""
}
