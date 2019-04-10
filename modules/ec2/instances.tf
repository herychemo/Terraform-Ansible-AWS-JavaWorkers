
resource "aws_network_interface" "web-ni" {
  subnet_id = "${var.subnet_id}"

  private_ips = [ "${var.instance_private_ip}" ]

  tags = {
    Name = "primary_network_interface"
    CreatedByTool = "Terraform"
  }
}

resource "aws_instance" "web-ec2s" {

  availability_zone = "${var.availability_zone}"

  ami           = "${var.instance_aws_ami}"
  instance_type = "${var.instance_type}"

  network_interface {
    network_interface_id = "${aws_network_interface.web-ni.id}"
    device_index         = 0
  }

  tags = {
    Name = "HelloWorld-EC2-Instance"
    CreatedByTool = "Terraform"
  }
}

