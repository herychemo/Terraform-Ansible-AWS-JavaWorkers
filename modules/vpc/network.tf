

resource "aws_vpc" "main_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"

  enable_dns_support = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags = {
    Name = "${var.vpc_name}-Vpc"
    CreatedByTool = "Terraform"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "${var.vpc_name}-Internet-GW"
    CreatedByTool = "Terraform"
  }
}


resource "aws_route" "internet_default_route" {
  route_table_id         = "${aws_vpc.main_vpc.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}


resource "aws_subnet" "subnets" {

  count = "${length(var.avz_names)}"


  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "${replace(var.subnet_cidr, var.subnet_number_template, count.index)}"

  availability_zone = "${element(var.avz_names, count.index)}"

  map_public_ip_on_launch = true

  depends_on = ["aws_internet_gateway.gw"]

  tags = {
    Name = "${var.vpc_name}-Subnet-${count.index}"
    CreatedByTool = "Terraform"
  }
}



output "vpc_id" {
  value = "${aws_vpc.main_vpc.id}"
}

output "vpc_subnets_ids" {
  value = "${aws_subnet.subnets.*.id}"
}

output "vpc_subnets_cidrs" {
  value = "${aws_subnet.subnets.*.cidr_block}"
}

