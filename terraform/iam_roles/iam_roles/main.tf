#------------iam_r/main.tf---------

resource "aws_iam_role" "bastion_iam_role" {
  name               = "${var.bastion_iam_role_name}"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}



resource "aws_iam_instance_profile" "bastion_iam_profile" {                             
  name  = "${var.bastion_iam_profile_name}"                         
  roles = ["${aws_iam_role.bastion_iam_role.name}"]
}

