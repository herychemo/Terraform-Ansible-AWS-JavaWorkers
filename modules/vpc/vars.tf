
# Network variables

variable "avz_names" {
  type = "list"
}


variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "vpc_tenancy" {
  default = "default"
}


variable "subnet_number_template" {
  default = "SUBNET_NUMBER"
}
variable "subnet_cidr" {
  default = "192.168.SUBNET_NUMBER.0/24",
}

