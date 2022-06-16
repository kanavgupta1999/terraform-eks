module "vpc" {
  source               = "./modules/vpc"
  name                 = "${local.name}"
  vpc_cidr             = "${local.vpc_cidr}"
  public_subnets_cidr  = "${local.public_subnets_cidr}"
  private_subnets_cidr = "${local.private_subnets_cidr}"
  public_cidr_block    = "${local.public_cidr_block}"
  private_cidr_block    = "${local.private_cidr_block}"
}
module "iam"{
 source        = "./modules/iam"
 name          = "${local.name}"
}
module "ad_security_group" {
  source    = "./modules/ad_security_group"
  name = "${local.name}"
  vpc_id = module.vpc.vpc_id
}
module "cluster"{
 source         = "./modules/cluster"
 name           = "${local.name}"
 role_arn       = module.iam.role_arn
 public_subnet  = module.vpc.public_subnets_id
 eks_depends_on = [module.iam]
}
module "node"{
 source                    = "./modules/node"
 name                      = "${local.name}"
 eks_depends_on            = [module.iam]
 cluster_name              = module.cluster.cluster_name
 node_role_arn             = module.iam.node_role_arn
 instance_types            = "${local.instance_types}"
 desired_size              = "${local.desired_size}"
 max_size                  = "${local.max_size}"
 min_size                  = "${local.min_size}"
 private_subnet            = module.vpc.private_subnets_id
 ec2_ssh_key               = "${local.ec2_ssh_key}"
 source_security_group_ids = module.ad_security_group.ad_security_group_id
 max_unavailable           = "${local.max_unavailable}"
}