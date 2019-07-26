#------------------root/main.tf----------------------
#----------------security module ---------------------
module "iam_roles" {
  source             = "./iam_roles"
  tags_environment   = "${var.tags_environment}"
  key_name           = "${var.key_name}"
  public_key_path    = "${var.public_key_path}"
  private_key_path   = "${var.private_key_path}"
  jenkins_kms_alias  = "${var.jenkins_kms_alias}"
  tags_costcentre    = "${var.tags_costcentre}"
  tags_owner         = "${var.tags_owner}"
  tags_applicationID = "${var.tags_applicationID}"
}

terraform {
  backend "s3" {
    bucket = "9328-test-bucket"
    key    = "jenkins-poc-stack/terraform.tfstate"
    region = "ap-southeast-2"
  }
}