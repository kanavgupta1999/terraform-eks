resource "aws_security_group" "ad_security_group" {
  name        = "${var.name}-security_group"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
  }
  tags = {
    name = "${var.name}"
  }
}