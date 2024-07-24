terraform {
  backend "s3" {
    bucket = "ot-micro-services-p9"
    key    = "terraformp9/terraform.tfstate"
    region = "us-east-1"
  }
}
