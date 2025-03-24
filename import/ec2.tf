resource "aws_instance" "web" {
  ami                                  = "ami-08b5b3a93ed654d19"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1b"
  instance_type                        = "t2.micro"
  key_name                             = "ec2-keypair"
  monitoring                           = false
  subnet_id                            = "subnet-05d5f9aa5c86bf662"
  vpc_security_group_ids      = ["sg-03a4844f4b648bcd9"]
  tags = {
    Name = "Terraform-import"
  }
}
  
  
