# security-groups/outputs.tf

output "sg_ec2_sg_ssh_http_id" {
  # Change 'ec2_sg' to whatever comes after 'resource "aws_security_group"' in your main.tf
  value = aws_security_group.ec2_sg.id 
}

output "eks_cluster_sg_id" {
  value = aws_security_group.eks_cluster.id
}

output "eks_node_sg_id" {
  value = aws_security_group.eks_nodes.id
}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_sg.id
}
