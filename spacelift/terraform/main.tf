provider "aws" {
  region = "ap-south-1"
}

# with the data fetching and filter we will fetch the AMI id of ubuntu from Canonical(provides AMI for ubuntu on aws) AWS id
data "aws_ami" "ubuntu" { # data is used for fetch existing information from aws
 
  most_recent = true # give me most recent created AMI 

  filter {
    name   = "name" # specifies which attribute of aws resource we want to filter
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] # filter the AMI based on the OS Image name 
  }

  filter {
    name   = "virtualization-type"  # specifies which attribute of aws resource we want to filter
    values = ["hvm"]  # select the AMI which has hvm as virtualization type 
  } 

  filter {
    name   = "architecture"
    values = ["x86_64"] # select the AMI which has x86_64 architecture
  }

  owners = ["099720109477"] #canonical AWS ID

}

locals {
  instances = {
    instances1 = {
        ami = data.aws_ami.ubuntu.id
        instance_type = var.instances_type
    }
     instances2 = {
        ami = data.aws_ami.ubuntu.id
        instance_type = var.instances_type
    }
     instances3 = {
        ami = data.aws_ami.ubuntu.id
        instance_type = var.instances_type
    }
     instances4 = {
        ami = data.aws_ami.ubuntu.id
        instance_type = var.instances_type
    }
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "instance-access-key"
  public_key = file(var.public_key)
}


resource "aws_instance" "spacelift-server" {
 for_each =  local.instances # lopping with the key value pair
 
 ami = each.value.ami
 instance_type = each.value.instance_type
 key_name = aws_key_pair.ssh-key.key_name 
 associate_public_ip_address = true 

 tags= {
    Name = each.key
 }

}
