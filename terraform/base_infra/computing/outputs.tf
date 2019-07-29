#-------------------computing/outputs.tf file ------------------

output "bastion_instance" {
  value = "${aws_instance.bastion_instance}"
}


