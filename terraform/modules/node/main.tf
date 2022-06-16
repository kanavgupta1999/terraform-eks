
resource "aws_eks_node_group" "node" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.name}-eks_node"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet
  instance_types  = [var.instance_types]
  
  remote_access {
    ec2_ssh_key               = var.ec2_ssh_key
    source_security_group_ids = [var.source_security_group_ids]
  }
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }
  depends_on = [var.eks_depends_on]
}