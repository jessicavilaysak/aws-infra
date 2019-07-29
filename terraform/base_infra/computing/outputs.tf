#-------------------computing/outputs.tf file ------------------

output "bastion_instance" {
  value = "${aws_instance.bastion_instance}"
}

output "jenkins_load_balancer" {
  value = "${aws_lb.jenkins_lb}"
}


