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
  jenkins_tooling_lb_sg_name = "${var.jenkins_tooling_lb_sg_name}"
  all_inbound_cidrs = "${var.all_inbound_cidrs}"
  all_outbound_cidrs = "${var.all_outbound_cidrs}"
  http_port = "${var.http_port}"
  https_port = "${var.https_port}"
}

module "computing" {
  source = "./computing"
  vpc_id = "${var.tools_vpc_id}"
  ami_filter_name = "${var.ami_filter_name}"
  ami_filter_pattern_jenkins = "${var.ami_filter_pattern_jenkins}"
  ami_filter_pattern_bastion = "${var.ami_filter_pattern_bastion}"
  bastion_iam_profile = "${module.roles.bastion_iam_profile_id}"
  bastion_instance_type = "${var.bastion_instance_type}"
  bastion_instance_sg = "${module.security_groups.bastion_sg_id}"
  key_pair = "${var.key_pair}"
  subnet_id = "${var.subnet_id}"
  subnet_ids = "${var.subnet_ids}"
  ami_owner_amazon = "${var.ami_owner_amazon}"
  jenkins_lb_sg = "${module.security_groups.jenkins_lb_sg_id}"
  https_port = "${var.https_port}"
  http_port = "${var.http_port}"
  lb_cert_arn = "${var.lb_cert_arn}"
  jenkins_instance_type = "${var.jenkins_instance_type}"
  jenkins_iam_profile = "${module.roles.jenkins_iam_profile_id}"
  jenkins_instance_sg = "${module.security_groups.jenkins_sg_id}"
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


