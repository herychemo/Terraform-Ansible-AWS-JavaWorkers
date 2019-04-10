
# Instances variables

variable "availability_zone" {}

variable "subnet_id" {}

variable "instance_aws_ami" {}

variable "instance_private_ip" {}

variable "instance_type" {
  default = "t2.micro"
}

