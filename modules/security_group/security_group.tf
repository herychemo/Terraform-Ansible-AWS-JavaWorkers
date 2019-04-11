
resource "aws_security_group" "a_security_group" {

  name        = "${var.group_name}"
  description = "${var.group_description}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.ingress_from_port}"
    to_port     = "${var.ingress_to_port}"
    protocol    = "${var.ingress_protocol}"
    cidr_blocks     = "${var.ingress_cidr_blocks}"
  }

  egress {
    from_port       = "${var.egress_from_port}"
    to_port         = "${var.egress_to_port}"
    protocol        = "${var.egress_protocol}"
    cidr_blocks     = "${var.egress_cidr_blocks}"
  }

  tags = {
    Name = "${var.group_name}"
    CreatedByTool = "Terraform"
  }
}


output "security_group_id" {
  value = "${aws_security_group.a_security_group.id}"
}
