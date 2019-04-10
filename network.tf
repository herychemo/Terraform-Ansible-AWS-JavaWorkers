
resource "aws_vpc" "main_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "Main-Vpc"
    CreatedByTool = "Terraform"
  }
}


resource "aws_subnet" "subnets" {

  count = "${length(data.aws_availability_zones.azs.names)}"

  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "${replace(var.subnet_cidr, var.subnet_number_template, count.index)}"

  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"

  tags = {
    Name = "Subnet-${count.index}"
    CreatedByTool = "Terraform"
  }
}

