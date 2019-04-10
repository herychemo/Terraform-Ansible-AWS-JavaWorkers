
resource "aws_network_interface" "web-ni" {
  subnet_id = "${element(aws_subnet.subnets.*.id, 0)}"
  private_ips = ["192.168.0.100"]

  tags = {
    Name = "primary_network_interface"
    CreatedByTool = "Terraform"
  }
}

resource "aws_instance" "web-ec2s" {

  availability_zone = "${element(data.aws_availability_zones.azs.names, 0)}"

  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = "${aws_network_interface.web-ni.id}"
    device_index         = 0
  }

  tags = {
    Name = "HelloWorld EC2 Instance"
    CreatedByTool = "Terraform"
  }
}

