resource "aws_instance" "jump_vm" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  
  # Ensures the OS initializes with a public interface
  associate_public_ip_address = true 

  tags = { Name = "JumpVM" }
}

# Add an output here so the IP goes to the root
output "public_ip" {
  value = aws_instance.jump_vm.public_ip
}
