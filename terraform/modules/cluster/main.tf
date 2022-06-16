resource "aws_eks_cluster" "cluster" {
  name     = "${var.name}-eks_cluster"
  role_arn = var.role_arn

  vpc_config {
    subnet_ids              = var.public_subnet
  }

  depends_on = [var.eks_depends_on]
}