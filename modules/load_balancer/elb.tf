
# Create a new load balancer
resource "aws_elb" "load_balander" {
  name               = "${var.load_balancer_name}"

  security_groups = ["${var.vpc_security_group_ids}"]
  subnets = ["${var.subnet_ids}"]

  /*
  access_logs {
    bucket        = "foo"
    bucket_prefix = "bar"
    interval      = 60
  }
  */

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.lb_protocol}"
  }

  /*
  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }
  */

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "${var.health_check_pattern}"
    interval            = 20
  }

  instances = ["${var.instance_ids}"]

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400


  tags = {
    Name = "${var.load_balancer_name}"
    CreatedByTool = "Terraform"
  }

}

output "public_access" {
  value = "${aws_elb.load_balander.dns_name}"
}
