#-------------------root/outputs.tf file ------------------

output "bastion_sg" {
  value = "${aws_security_group.bastion_tooling_sg.id}"
}

output "jenkins_sg" {
  value = "${aws_security_group.jenkins_tooling_sg.id}"
}

output "jenkins_lb_sg"{
  value = "${aws_security_group.jenkins_tooling_lb_sg.id}"
}

