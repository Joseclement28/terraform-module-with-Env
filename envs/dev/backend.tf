terraform {
  backend "s3" {
    bucket         = "my-terraform-state-demo-123-456"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = "true"
  }
}

