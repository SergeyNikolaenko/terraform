provider "aws" {
  region = var.region
}

terraform {
	required_providers {
		aws = {
	    version = "~> 4.39.0"
		}
  }
}
