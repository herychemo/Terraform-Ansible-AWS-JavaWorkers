

resource "aws_eip" "instance_eips" {

  count = "${var.add_public_ip}"

  vpc = true

  instance = "${aws_instance.ec2-instance.id}"
  associate_with_private_ip = "${var.instance_private_ip}"

  tags {
    Name = "${var.instance_name}_EIP"
    CreatedByTool = "Terraform"
  }

  depends_on = ["aws_instance.ec2-instance"]
}

resource "aws_instance" "ec2-instance" {

  availability_zone = "${var.availability_zone}"

  ami           = "${var.instance_aws_ami}"
  instance_type = "${var.instance_type}"

  key_name = "${var.key_pair_name}"

  associate_public_ip_address = "${var.add_public_ip}"

  subnet_id = "${var.subnet_id}"
  private_ip = "${var.instance_private_ip}"

  vpc_security_group_ids = ["${var.vpc_security_group_id}"]

  tags = {
    Name = "${var.instance_name}"
    CreatedByTool = "Terraform"
  }
}


output "instance_public_ip" {
  value = "${aws_eip.instance_eips.*.public_ip}"
}

/*
output "instance_public_ip" {
  value = "${aws_instance.ec2-instance.public_ip}"
}
*/
