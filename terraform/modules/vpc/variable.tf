variable "name" {
  description = "The Deployment environment"
}

variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}
variable "public_subnets_cidr" {
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  description = "The CIDR block for the private subnet"
}
variable "public_cidr_block" {
  description = "The CIDR block for the public aws route"
}
variable "private_cidr_block" {
  description = "The CIDR block for the private aws route"
}