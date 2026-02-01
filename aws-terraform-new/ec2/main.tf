# ec2/main.tf

resource "aws_instance" "jump_vm" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = true # MUST be true

  tags = {
    Name = "JumpVM"
  }
}
