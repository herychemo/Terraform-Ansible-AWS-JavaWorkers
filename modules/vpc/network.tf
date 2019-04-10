

resource "aws_vpc" "main_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"

  tags = {
    Name = "Main-Vpc"
    CreatedByTool = "Terraform"
  }
}

resource "aws_subnet" "subnets" {

  count = "${length(var.avz_names)}"


  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "${replace(var.subnet_cidr, var.subnet_number_template, count.index)}"

  availability_zone = "${element(var.avz_names, count.index)}"

  tags = {
    Name = "Subnet-${count.index}"
    CreatedByTool = "Terraform"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main_vpc.id}"
}

output "vpc_subnets_ids" {
  value = "${aws_subnet.subnets.*.id}"
}

