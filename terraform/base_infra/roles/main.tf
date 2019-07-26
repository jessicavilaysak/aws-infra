#------------role/main.tf---------

###
# These resources are used for the bastion user's IAM role/profile/policy
###
resource "aws_iam_role" "bastion_iam_role" {
  name               = "${var.bastion_iam_role_name}"
  assume_role_policy = "${file("${path.module}/files/bastion_assume_role_policy.json")}"
}

resource "aws_iam_instance_profile" "bastion_iam_profile" {                             
  name  = "${var.bastion_iam_profile_name}"                         
  roles = ["${aws_iam_role.bastion_iam_role.name}"]
}

resource "aws_iam_role_policy" "bastion_policy" {
  name = "bastion_policy"
  role = "${aws_iam_role.bastion_iam_role.id}"
  policy = "${file("${path.module}/files/bastion_role_policy.json")}"
}

###
# These resources are used for the jenkins master's IAM role/profile/policy
###
resource "aws_iam_role" "jenkinsmaster_iam_role" {
  name               = "${var.jenkinsmaster_iam_role_name}"
  assume_role_policy = "${file("${path.module}/files/jenkinsmaster_assume_role_policy.json")}"
}

resource "aws_iam_instance_profile" "jenkinsmaster_iam_profile" {                             
  name  = "${var.jenkinsmaster_iam_profile_name}"                         
  roles = ["${aws_iam_role.jenkinsmaster_iam_role.name}"]
}

resource "aws_iam_role_policy" "jenkinsmaster_policy" {
  name = "jenkinsmaster_policy"
  role = "${aws_iam_role.jenkinsmaster_iam_role.id}"
  policy = "${file("${path.module}/files/jenkinsmaster_role_policy.json")}"
}


