############### Tags ###############

variable "project" {
    default = "TEST"
}

variable "env" {
    default = "dev"
}

variable "owner" {
    default = "serhiy.nikolaenko"
}

############### VPC ###############

variable "region" {
    default = "es-east-1"
}

variable "vpc_cidr_block" {
    default = "10.100.0.0/16"
}

variable "ext_subnet_a_cidr_block" {
    default = "10.100.11.0/24"
}

variable "ext_subnet_b_cidr_block" {
    default = "10.100.22.0/24"
}

variable "int_subnet_a_cidr_block" {
    default = "10.100.10.0/24"
}

variable "int_subnet_b_cidr_block" {
    default = "10.100.20.0/24"
}

############### EC2 ###############

### AMI ###
variable "ami_ubuntu" {
  default = "ami-0a49b025fffbbdac6"
}

### jenkins_server ###
variable "instance_type_jenkins" {
  default = "t3.small"
}

variable "user_data_jenkins" {
  default = "./file/install_jenkins.sh"
}

### Docker_server ###
variable "instance_type_docker" {
  default = "t3.small"
}

variable "user_data_docker" {
  default = "./file/install_docker.sh"
}



