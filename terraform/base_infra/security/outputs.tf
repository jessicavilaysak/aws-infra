#-------------------security_groups/outputs.tf file ------------------

output "bastion_sg_id" {
  value = "${aws_security_group.bastion_tooling_sg.id}"
}

output "jenkins_sg_id" {
  value = "${aws_security_group.jenkins_tooling_sg.id}"
}

output "jenkins_lb_sg_id"{
  value = "${aws_security_group.jenkins_tooling_lb_sg.id}"
}

output "srv_account_kms"{
  value = "${aws_kms_key.srv_account_kms}"
}

