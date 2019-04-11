
# Network variables

variable "vpc_name" {
  default = "Main"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "vpc_tenancy" {
  default = "default"
}


variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}


variable "avz_names" {
  type = "list"
}

variable "subnet_number_template" {
  default = "SUBNET_NUMBER"
}
variable "subnet_cidr" {
  default = "192.168.SUBNET_NUMBER.0/24",
}

