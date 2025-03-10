resource "aws_instance" "server1" {
    availability_zone = "us-east-1a"
  instance_type   = "t2.micro"
  ami             = "ami-045269a1f5c90a6a0"
  vpc_security_group_ids = [aws_security_group.ws.id]
  user_data = file("code.sh")
  subnet_id = aws_subnet.priv1.id
  tags = {
    Name = "Webserver-1"
}
}

resource "aws_instance" "server2" {
    availability_zone = "us-east-1b"
  instance_type   = "t2.micro"
  ami             = "ami-045269a1f5c90a6a0"
  vpc_security_group_ids = [aws_security_group.ws.id]
  user_data = file("code.sh")
  subnet_id = aws_subnet.priv2.id
  tags = {
    Name = "Webserver-2"
  }
}