variable "name" {
  type = string
}
variable "role_arn" {
  type = string
}
variable "public_subnet" {
  type = any
}
variable "eks_depends_on" {
  type = list
}