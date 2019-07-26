#-------------------root/outputs.tf file ------------------

output "BASTION_IAM_PROFILE_NAME" {
  value = "${module.iam_roles.bastion_iam_profile.id}"
}
