#-------------------computing/outputs.tf file ------------------

output "bastion_instance" {
  value = "${aws_instance.bastion_instance}"
}

output "jenkins_asg" {
  value = "${aws_autoscaling_group.jenkins_asg}"
}


