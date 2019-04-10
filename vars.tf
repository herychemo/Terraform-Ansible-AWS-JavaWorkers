
// AWS Access
variable "access_key" {
  default = "AKIA25HSOJRJDBUC77GD"
}

variable "secret_key" {
  default = "r4N7jc/LOf1NNmn1REvfQphVsH3WWCoa0mYf4t9A"
}

variable "region" {
  default = "us-east-1"
}


variable "vpc_cidr" {
  default = "192.168.0.0/16"
}


variable "subnet_number_template" {
  default = "SUBNET_NUMBER"
}
variable "subnet_cidr" {
  default = "192.168.SUBNET_NUMBER.0/24",
}


# Declare data source

data "aws_availability_zones" "azs" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Constant
  owners = ["099720109477"] # Canonical
}