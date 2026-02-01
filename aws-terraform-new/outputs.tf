output "JUMP_VM_IP" {
  value = module.ec2.public_ip
}

output "JUMP_VM_ID" {
  value = module.ec2.instance_id
}
