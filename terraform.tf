terraform {
  backend "s3" {
    bucket = "sharjeelbucket1"
    key    = "TerraformDir/terraform.tfstate"
    region = "us-east-1"  #use this to represent global
  }
}
