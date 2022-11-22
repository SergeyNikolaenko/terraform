resource "aws_subnet" "ext_subnet_a" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = var.ext_subnet_a_cidr_block
  map_public_ip_on_launch         = "true"
  vpc_id                          = aws_vpc.vpc.id
  availability_zone               = "${var.region}a"

  
  tags = {
    Name     = "${var.env}_ext_subnet_a"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "subnet"
  }
}

resource "aws_subnet" "ext_subnet_b" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = var.ext_subnet_b_cidr_block
  map_public_ip_on_launch         = "true"
  vpc_id                          = aws_vpc.vpc.id
  availability_zone               = "${var.region}b"
  
  tags = {
    Name     = "${var.env}_ext_subnet_b"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "subnet"
  }
}

resource "aws_internet_gateway" "gw_ext_subnets" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "${var.env}_gw_ext_subnets"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "internet_gateway"
  }
}

resource "aws_route_table" "rtb_ext_subnet" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_ext_subnets.id
  }

  tags = {
    Name     = "${var.env}_rtb_ext_subnet"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "route_table"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "ext_subnet_a" {
  route_table_id = aws_route_table.rtb_ext_subnet.id
  subnet_id      = aws_subnet.ext_subnet_a.id
  

  depends_on = [aws_route_table.rtb_ext_subnet]
}

resource "aws_route_table_association" "ext_subnet_b" {
  route_table_id = aws_route_table.rtb_ext_subnet.id
  subnet_id      = aws_subnet.ext_subnet_b.id
  

  depends_on = [aws_route_table.rtb_ext_subnet]
}