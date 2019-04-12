

resource "aws_eip" "instance_eips" {

  count = "${var.add_public_ip * var.n_of_instances}"

  vpc = true

  instance = "${element(aws_instance.ec2-instances.*.id, count.index)}"
  associate_with_private_ip = "${element(aws_instance.ec2-instances.*.private_ip, count.index)}"

  tags {
    Name = "EIP-${var.instance_name}-${count.index}"
    CreatedByTool = "Terraform"
  }

  depends_on = ["aws_instance.ec2-instances"]
}

resource "aws_instance" "ec2-instances" {

  count = "${var.n_of_instances}"

  availability_zone = "${var.availability_zone}"

  ami           = "${var.instance_aws_ami}"
  instance_type = "${var.instance_type}"

  key_name = "${var.key_pair_name}"

  associate_public_ip_address = "${var.add_public_ip}"

  subnet_id = "${var.subnet_id}"
  private_ip = "${cidrhost(var.subnet_cidr_block, var.instance_host_n_in_subnet_cidr + count.index)}"

  vpc_security_group_ids = ["${var.vpc_security_group_id}"]

  tags = {
    Name = "${var.instance_name}-${count.index}"
    CreatedByTool = "Terraform"
  }
}


output "instance_public_ips" {
  value = "${aws_eip.instance_eips.*.public_ip}"
}
