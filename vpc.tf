# Create vpc

resource "aws_vpc" "v1" {
  cidr_block           = "172.120.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "Utc-app"
    Team = "cloud team"
  }
}

# Internet gateway
resource "aws_internet_gateway" "gtw" {
  vpc_id = aws_vpc.v1.id

}

# Public subnets

resource "aws_subnet" "pub1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.v1.id
  cidr_block        = "172.120.1.0/24"
}
resource "aws_subnet" "pub2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.v1.id
  cidr_block        = "172.120.2.0/24"
}


# Private subnets

resource "aws_subnet" "priv1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.v1.id
  cidr_block        = "172.120.3.0/24"
}
resource "aws_subnet" "priv2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.v1.id
  cidr_block        = "172.120.4.0/24"
}


# Nat gateway

resource "aws_eip" "eip1" {}

resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.pub1.id
}

# Private Route Table

resource "aws_route_table" "rtprivate" {
  vpc_id = aws_vpc.v1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id

  }
}

# Public Route Table

resource "aws_route_table" "rtpublic" {
  vpc_id = aws_vpc.v1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw.id

  }
}

# Public route table association

resource "aws_route_table_association" "purt1" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.rtpublic.id
}

resource "aws_route_table_association" "purt2" {
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.rtpublic.id
}

# Private route table association

resource "aws_route_table_association" "privt1" {
  subnet_id      = aws_subnet.priv1.id
  route_table_id = aws_route_table.rtprivate.id
}

resource "aws_route_table_association" "privt2" {
  subnet_id      = aws_subnet.priv2.id
  route_table_id = aws_route_table.rtprivate.id
}