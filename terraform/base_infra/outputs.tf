#-------------------root/outputs.tf file ------------------

output "BASTION_IAM_PROFILE" {
  value = "${module.roles.bastion_iam_profile_id}"
}

output "JENKINS_IAM_PROFILE" {
  value = "${module.roles.jenkins_iam_profile_id}"
}

output "BASTION_SG" {
  value = "${module.security.bastion_sg_id}"
}

output "JENKINS_SG" {
  value = "${module.security.jenkins_sg_id}"
}

output "JENKINS_LB_SG" {
  value = "${module.security.jenkins_lb_sg_id}"
}

output "BASTION_INSTANCE" {
  value = "${module.computing.bastion_instance}"
}

output "JENKINS_LOAD_BALANCER" {
  value = "${module.computing.jenkins_load_balancer}"
}


