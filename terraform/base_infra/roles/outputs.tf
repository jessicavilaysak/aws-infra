#-------------------root/outputs.tf file ------------------

output "bastion_iam_profile_id" {
  value = "${aws_iam_instance_profile.bastion_iam_profile}"
}
