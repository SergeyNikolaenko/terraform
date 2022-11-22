resource "aws_subnet" "int_subnet_a" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = var.int_subnet_a_cidr_block
  map_public_ip_on_launch         = "false"
  vpc_id                          = aws_vpc.vpc.id
  availability_zone               = "${var.region}a"

  tags = {
    Name     = "${var.env}_int_subnet_a"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "subnet"
  }
}

resource "aws_subnet" "int_subnet_b" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = var.int_subnet_b_cidr_block
  map_public_ip_on_launch         = "false"
  vpc_id                          = aws_vpc.vpc.id
  availability_zone               = "${var.region}b"

  tags = {
    Name     = "${var.env}_int_subnet_b"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "subnet"
  }
}


resource "aws_eip" "eip_nat_gateway" {
  vpc = true

  tags = {
    Name     = "${var.env}_eip_nat_gateway"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "eip"
  }

  depends_on = [aws_internet_gateway.gw_ext_subnets]
}

resource "aws_nat_gateway" "nat_int_subnets" {
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id     = aws_subnet.ext_subnet_a.id

  tags = {
    Name     = "${var.env}_nat_int_subnets"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "nat_gateway"
  }

  depends_on = [aws_eip.eip_nat_gateway]
}

resource "aws_route_table" "rtb_int_subnet" {
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_int_subnets.id
  }

  tags = {
    Name     = "${var.env}_rtb_int_subnet"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "route_table"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "subnet_int_a" {
  route_table_id = aws_route_table.rtb_int_subnet.id
  subnet_id      = aws_subnet.int_subnet_a.id

  depends_on = [aws_route_table.rtb_int_subnet]
}

resource "aws_route_table_association" "subnet_int_b" {
  route_table_id = aws_route_table.rtb_int_subnet.id
  subnet_id      = aws_subnet.int_subnet_b.id

  depends_on = [aws_route_table.rtb_int_subnet]
}
