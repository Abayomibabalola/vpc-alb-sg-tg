provider "aws" {
    region = "us-east-1"
    profile = "default"
}

import {
  to = aws_instance.web
  id = "i-06f2d1cee174b281b"
}