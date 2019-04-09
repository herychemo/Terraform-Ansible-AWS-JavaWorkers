
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

variable "subnet_cidr" {
  type = "list"
  default =  [
    "192.168.0.0/24",
    "192.168.1.0/24",
    "192.168.2.0/24",
    "192.168.3.0/24",
    "192.168.4.0/24",
    "192.168.5.0/24",
    "192.168.6.0/24"
  ]
}

# Declare data source

data "aws_availability_zones" "azs" {}
