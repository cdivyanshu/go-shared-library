terraform {
  backend "s3" {
    bucket = "ot-micro-service-p9"
    key    = "terraformp9/*"
    region = "us-east-1"
  }
}
