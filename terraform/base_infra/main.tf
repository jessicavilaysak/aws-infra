#------------------root/main.tf----------------------
#----------------security module ---------------------
module "roles" {
  source             = "./roles"
  bastion_iam_role_name     = "${var.bastion_iam_role_name}"
  bastion_iam_profile_name  = "${var.bastion_iam_profile_name}"
  jenkinsmaster_iam_role_name = "${var.jenkinsmaster_iam_role_name}"
  jenkinsmaster_iam_profile_name = "${var.jenkinsmaster_iam_profile_name}"
}

module "security_groups" {
  source = "./security_groups"
  ssh_port = "${var.ssh_port}"
  tools_vpc_id = "${var.tools_vpc_id}"
  bastion_tooling_sg_name = "${var.bastion_tooling_sg_name}"
  jenkins_tooling_sg_name = "${var.jenkins_tooling_sg_name}"
  all_inbound_cidrs = "${var.all_inbound_cidrs}"
  all_outbound_cidrs = "${var.all_outbound_cidrs}"
  http_port = "${var.http_port}"
  https_port = "${var.https_port}"
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


