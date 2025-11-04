terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.19.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_lightsail_static_ip" "alonsops-staticip" {
  name = "alonsops-staticip"
}

resource "aws_lightsail_instance" "alonsops-vps" {
  name              = "alonsops-vps"
  availability_zone = "us-east-1b"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_3_0"
  key_pair_name     = "MyKey"
  tags = {
    environment = "production"
  }
}

resource "aws_lightsail_static_ip_attachment" "alonsops-staticip-attachment" {
  static_ip_name = aws_lightsail_static_ip.alonsops-staticip.id
  instance_name = aws_lightsail_instance.alonsops-vps.id
}
