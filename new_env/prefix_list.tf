resource "aws_ec2_managed_prefix_list" "devops" {
  name           = "devops_prefix_list"
  address_family = "IPv4"
  max_entries    = 2

  entry {
    cidr        = "134.249.100.91/32"
    description = "serhiy.nikolaenko"
  }

  entry {
    cidr        = "133.249.100.55/32"
    description = "devops_name"
  }

  tags = {
    Name     = "${var.env}_prefix_list"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "prefix_list"
  }
  
}