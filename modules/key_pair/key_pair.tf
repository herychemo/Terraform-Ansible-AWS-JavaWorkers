
resource "aws_key_pair" "ec2-ssh-key" {
  key_name = "${var.ssh-key-name}"
  public_key = "${var.ssh-public-key}"
}

output "ssh_key_name" {
  value = "${aws_key_pair.ec2-ssh-key.key_name}"
}
