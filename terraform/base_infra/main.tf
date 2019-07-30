#------------------root/main.tf----------------------

## Lets get current aws account info
data "aws_caller_identity" "current" {}

module "roles" {
  source             = "./roles"
  bastion_iam_role_name     = "${var.bastion_iam_role_name}"
  bastion_iam_profile_name  = "${var.bastion_iam_profile_name}"
  jenkins_iam_role_name = "${var.jenkins_iam_role_name}"
  jenkins_iam_profile_name = "${var.jenkins_iam_profile_name}"
}

module "security" {
  source = "./security"
  aws_caller_identity = "${data.aws_caller_identity.current}"
  ssh_port = "${var.ssh_port}"
  tools_vpc_id = "${var.tools_vpc_id}"
  all_inbound_cidrs = "${var.all_inbound_cidrs}"
  all_outbound_cidrs = "${var.all_outbound_cidrs}"
  http_port = "${var.http_port}"
  https_port = "${var.https_port}"

  bastion_tooling_sg_name = "${var.bastion_tooling_sg_name}"
  jenkins_tooling_sg_name = "${var.jenkins_tooling_sg_name}"
  jenkins_tooling_lb_sg_name = "${var.jenkins_tooling_lb_sg_name}"
  jenkins_role_name = "${module.roles.jenkins_iam_role_name}"
  ssm_github_priv_key = "${var.ssm_github_priv_key}"
  ssm_github_pub_key = "${var.ssm_github_pub_key}"
  tags_executedby = "${var.tags_executedby}"
}

module "computing" {
  source = "./computing"
  vpc_id = "${var.tools_vpc_id}"
  region = "${var.region}"
  https_port = "${var.https_port}"
  http_port = "${var.http_port}"
  lb_cert_arn = "${var.lb_cert_arn}"
  key_pair = "${var.key_pair}"
  subnet_id = "${var.subnet_id}"
  subnet_ids = "${var.subnet_ids}"
  tags_executedby = "${var.tags_executedby}"

  ami_owner_amazon = "${var.ami_owner_amazon}"
  ami_filter_name = "${var.ami_filter_name}"
  ami_filter_pattern_jenkins = "${var.ami_filter_pattern_jenkins}"
  ami_filter_pattern_bastion = "${var.ami_filter_pattern_bastion}"
  bastion_iam_profile = "${module.roles.bastion_iam_profile_id}"
  bastion_instance_type = "${var.bastion_instance_type}"
  bastion_instance_sg = "${module.security.bastion_sg_id}"
  jenkins_lb_sg = "${module.security.jenkins_lb_sg_id}"
  jenkins_instance_type = "${var.jenkins_instance_type}"
  jenkins_iam_profile = "${module.roles.jenkins_iam_profile_id}"
  jenkins_instance_sg = "${module.security.jenkins_sg_id}"
  jenkins_repo_download_link = "${var.jenkins_repo_download_link}"
  jenkins_repo_import_link = "${var.jenkins_repo_import_link}"
  ssm_github_priv_key = "${var.ssm_github_priv_key}"
  ssm_github_pub_key = "${var.ssm_github_pub_key}"
  jenkins_ssh_folder_path = "${var.jenkins_ssh_folder_path}"
}

module "storage" {
  source = "./storage"
  jenkins_bucket_name = "${var.jenkins_bucket_name}"
  srv_account_kms = "${module.security.srv_account_kms_alias}"
  
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


