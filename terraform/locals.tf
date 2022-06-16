locals{
    name                          = "oodles"
    vpc_cidr                      = "10.0.0.0/16"
    public_subnets_cidr           = "10.0.0.0/24"
    private_subnets_cidr          = "10.0.1.0/24"
    public_cidr_block             = "0.0.0.0/0"
    private_cidr_block            = "0.0.0.0/0"
    aws_region                    = "us-east-1" 
    aws_profile                   = "sweat"   
    instance_types                = "t2.micro"
    desired_size                  = "1"
    max_size                      = "1"
    min_size                      = "1"
    ec2_ssh_key                   = "lambda"
    max_unavailable               = "1"

}