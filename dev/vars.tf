
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

variable "main_vpc_name" {
  default = "Main"
}

variable "main_instance_ssh_key_name" {
  default = "tf_main"
}

variable "main_instance_ssh_public_key_path" {
  default = "../ssh_keys/tf_main/tf_main.pub"
}

variable "main_instances_name" {
  default = "Main"
}

variable "main_instances_host_n_in_subnet_cidr" {
  default = 100
}

variable "main_instances_n_of_instances" {
  default = 2
}

variable "main_instance_add_public_ip" {
  default = true
}

