#-------------------root/outputs.tf file ------------------

output "bastion_iam_profile_id" {
  value = "${module.iam_roles.bastion_iam_profile.id}"
}
