#-------------------root/outputs.tf file ------------------

output "BASTION_IAM_PROFILE" {
  value = "${module.roles.bastion_iam_profile_id}"
}

output "JENKINSMASTER_IAM_PROFILE" {
  value = "${module.roles.jenkinsmaster_iam_profile_id}"
}

output "BASTION_SG" {
  value = "${module.security_groups.bastion_sg}"
}

output "JENKINS_SG" {
  value = "${module.security_groups.jenkins_sg}"
}

output "JENKINS_LB_SG" {
  value = "${module.security_groups.jenkins_lb_sg}"
}


