resource "aws_eip" "eip_jenkins" {
  vpc = true

  instance                  = aws_instance.jenkins.id
  associate_with_private_ip = aws_instance.jenkins.private_ip
  
  depends_on                = [aws_instance.jenkins]

  tags = {
      Name     = "${var.env}_eip_jenkins"
      Owner    = var.owner
      Env      = var.env
      Project  = var.project
      Resource = "eip"
    }
}

