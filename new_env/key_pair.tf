resource "aws_key_pair" "key_pair_ext" {
  key_name   = "${var.env}_ext_key"
  public_key = file("./file/ssh_key_ext.sh")

  tags = {
    Name     = "${var.env}_ext_key"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "key_pair"
  }
}


resource "aws_key_pair" "key_pair_int" {
  key_name   = "${var.env}_int_key"
  public_key = file("./file/ssh_key_int.sh")

  tags = {
    Name     = "${var.env}_int_key"
    Owner    = var.owner
    Env      = var.env
    Project  = var.project
    Resource = "key_pair"
  }
}