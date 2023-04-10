provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA4WWG6N4B2VEC7FVX"
  secret_key = "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"
}
resource "aws_vpc" "devops_training" {
    cidr_block = "10.0.0.0/16"
    tags={ Name="devops-trainig"}

}
resource "aws_subnet" "pub_subnet_a" {

  vpc_id = aws_vpc.devops_training.id
  availability_zone = "ap-south-1a"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags={
    Name = "public_subnet_A"
  }
}

resource "aws_internet_gateway" "pub_gw" {
  vpc_id = aws_vpc.devops_training.id
  
}
resource "aws_route_table" "pub_routetbl" {
vpc_id = aws_vpc.devops_training.id
route {
  cidr_block="0.0.0.0/0"
  gateway_id=aws_internet_gateway.pub_gw.id
} 

  tags= {
    Name = "pub_route_tbl"

}
}
resource "aws_route_table_association" "pub_routeassoc" {
  route_table_id = aws_route_table.pub_routetbl.id
  subnet_id =  aws_subnet.pub_subnet_a.id
}

resource "aws_security_group" "pub_secgroup" {

  vpc_id = aws_vpc.devops_training.id
  description = "For ec2-instance-prod" 

  ingress {
    description="SSH port"
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  ingress{
    from_port=8080
    to_port=8080
    description="Jenkins"
    cidr_blocks=["0.0.0.0/0"]
    protocol="tcp"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol="tcp"
    description = "https"
    cidr_blocks = ["0.0.0.0/0"]
  
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    description ="http"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
from_port=0
to_port=0
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
}

resource "aws_instance" "server_nqueens" {
    ami = "ami-0376ec8eacdf70aae"
    availability_zone = "ap-south-1a"
    instance_type = "t2.micro"
    tags = {"Name"="Terminate-me"}
    key_name = "terraform-key"
    network_interface {
      network_interface_id = aws_network_interface.nw_nqueens.id
      device_index = 0

    }

}

resource "aws_network_interface" "nw_nqueens" {

  subnet_id = aws_subnet.pub_subnet_a.id
  security_groups=[aws_security_group.pub_secgroup.id]
  private_ips = ["10.0.2.22"]
  
}
resource "aws_eip" "pub_ip_nqueens" {
  instance = aws_instance.server_nqueens.id
}







