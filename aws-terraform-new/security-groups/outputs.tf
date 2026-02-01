output "sg_ec2_sg_ssh_http_id" {
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
