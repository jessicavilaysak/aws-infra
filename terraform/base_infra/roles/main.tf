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
resource "aws_iam_role" "jenkins_iam_role" {
  name               = "${var.jenkins_iam_role_name}"
  assume_role_policy = "${file("${path.module}/files/jenkins_assume_role_policy.json")}"
}

resource "aws_iam_instance_profile" "jenkins_iam_profile" {                             
  name  = "${var.jenkins_iam_profile_name}"                         
  roles = ["${aws_iam_role.jenkins_iam_role.name}"]
}

resource "aws_iam_role_policy" "jenkins_policy" {
  name = "jenkins_policy"
  role = "${aws_iam_role.jenkins_iam_role.id}"
  policy = "${file("${path.module}/files/jenkins_role_policy.json")}"
}


