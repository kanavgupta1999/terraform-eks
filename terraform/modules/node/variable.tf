variable "name" {
  type = string
}
variable "eks_depends_on" {
  type = list
}
variable "cluster_name" {
  type = string
}
variable "node_role_arn" {
  type = string
}
variable "instance_types" {
  type = string
}
variable "desired_size" {
  type = string
}
variable "max_size" {
  type = string
}
variable "min_size" {
  type = string
}
variable "private_subnet" {
  type = any
}
variable "ec2_ssh_key" {
  type = string
}
variable "source_security_group_ids" {
  type = string
}
variable "max_unavailable" {
  type = string
}