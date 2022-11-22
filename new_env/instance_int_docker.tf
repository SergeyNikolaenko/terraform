data "template_file" "user_data_docker" {
  template = file(var.user_data_docker)
}

resource "aws_instance" "docker" {
  count                       = "1"
  ami                         = var.ami_ubuntu
  instance_type               = var.instance_type_docker
  subnet_id                   = aws_subnet.int_subnet_a.id
  associate_public_ip_address = "false"
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [aws_security_group.int_docker_sg.id]
  user_data_base64            = base64encode(data.template_file.user_data_docker.rendered)
  key_name                    = aws_key_pair.key_pair_int.key_name


  root_block_device {
    delete_on_termination = "true"
    encrypted             = "false"
    volume_size           = "30"
    volume_type           = "gp2"

    tags = {
      Name     = "${var.env}_docker_block_device"
      Owner    = var.owner
      Env      = var.env
      Project  = var.project
      Resource = "block_device"
    }
  }

  tags = {
    Name     = "${var.env}_api_ui"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "instance"
  }

  depends_on = [aws_security_group.int_docker_sg]
}

resource "aws_security_group" "int_docker_sg" {
  name   = "${var.env}_int_api_ui_sg"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "22"]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      prefix_list_ids = [aws_ec2_managed_prefix_list.devops.id]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/16"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.env}_int_api_ui_sg"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "security_group"
  }

  depends_on = [aws_ec2_managed_prefix_list.devops]

}
