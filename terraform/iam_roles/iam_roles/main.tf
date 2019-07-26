#------------iam_r/main.tf---------

resource "aws_iam_role" "bastion_iam_role" {
  name               = "${var.bastion_iam_role_name}"
}



resource "aws_iam_instance_profile" "bastion_iam_profile" {                             
  name  = "${var.bastion_iam_profile_name}"                         
  roles = ["${aws_iam_role.bastion_iam_role.name}"]
}

resource "aws_iam_role_policy" "bastion_policy" {
  name = "bastion_policy"
  role = "${aws_iam_role.bastion_iam_role.id}"

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ec2:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}


