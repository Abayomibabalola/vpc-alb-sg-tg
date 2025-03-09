terraform {
  backend "s3" {
    bucket         = "week6-ab-bucket-terraform"
    key            = "week10/terrafform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}