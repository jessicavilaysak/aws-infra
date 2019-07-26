#-------------------root/outputs.tf file ------------------

output "BASTION_IAM_PROFILE" {
  value = "${module.roles.bastion_iam_profile_id}"
}

output "JENKINSMASTER_IAM_PROFILE" {
  value = "${module.roles.jenkinsmaster_iam_profile_id}"
}
