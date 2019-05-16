
variable "vpc_security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

variable "instance_ids" {
  type = "list"
}

variable "load_balancer_name" {}


variable "instance_port" {
  default = 5000
}
variable "instance_protocol" {
  default = "HTTP"
}

variable "lb_port" {
  default = 80
}

variable "lb_protocol" {
  default = "HTTP"
}


variable "health_check_pattern" {
  default = "HTTP:5000/health"
}
