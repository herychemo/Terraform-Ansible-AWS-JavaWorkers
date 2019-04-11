
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


variable "main_instance_ssh_key_name" {
  default = "tf_main"
}

variable "main_instance_ssh_public_key_path" {
  default = "../ssh_keys/tf_main/tf_main.pub"
}

variable "main_instance_private_ip" {
  default = "192.168.0.100"
}

variable "main_instance_add_public_ip" {
  default = true
}

