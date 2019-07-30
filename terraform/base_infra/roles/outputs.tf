#-------------------roles/outputs.tf file ------------------

output "bastion_iam_profile_id" {
  value = "${aws_iam_instance_profile.bastion_iam_profile.id}"
}

output "jenkins_iam_profile_id" {
  value = "${aws_iam_instance_profile.jenkins_iam_profile.id}"
}

output "jenkins_iam_role_name" {
  value = "${aws_iam_role.jenkins_iam_role.name}"
}

