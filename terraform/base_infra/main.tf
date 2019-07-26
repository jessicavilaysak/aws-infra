#------------------root/main.tf----------------------
#----------------security module ---------------------
module "roles" {
  source             = "./roles"
  bastion_iam_role_name     = "${var.bastion_iam_role_name}"
  bastion_iam_profile_name  = "${var.bastion_iam_profile_name}"
}


provider "aws" {
  region = "ap-southeast-2"
}


terraform {
  backend "s3" {
    bucket = "9328-test-bucket"
    key    = "jenkins-poc-stack/terraform.tfstate"
    region = "ap-southeast-2"
  }
}


