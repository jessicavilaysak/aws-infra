#------------------root/main.tf----------------------
#----------------security module ---------------------
module "iam_roles" {
  source             = "./iam_roles"
  bastion_iam_role_name     = "${var.bastion_iam_role_name}"
  bastion_iam_profile_name  = "${var.bastion_iam_profile_name}"
}

terraform {
  backend "s3" {
    bucket = "${s3_backend_bucket}"
    key    = "${s3_backend_bucket_path}"
    region = "${region}"
  }
}