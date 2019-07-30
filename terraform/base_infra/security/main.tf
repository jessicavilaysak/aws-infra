#------------security_groups/main.tf---------



## Strategy for SSM params for git service account
##  - initially you create a KMS manually
##  - use the KMS to create encrypted SSM params for priv and pub keys
##  - once you run the terraform, it will take those params and 
##    create new SSM params with a new KMS

data "aws_ssm_parameter" "git_private_key" {
  name = "${var.ssm_github_priv_key}"
}

data "aws_ssm_parameter" "git_public_key" {
  name = "${var.ssm_github_pub_key}"
}

data "template_file" "srv_account_kms_policy_template" {
  template = "${file("${path.module}/files/srv_account_kms_policy.tpl")}"
  vars = {
    policy_id = "srv_account_kms_policy"
    account_id = "${var.aws_caller_identity.account_id}"
    jenkins_role_name = "${var.jenkins_role_name}"
  }
}

## CREATE a new KMS here which is used to encrypt the SSM github params
resource "aws_kms_key" "srv_account_kms" {
  description = "Key created by ${var.tags_executedby}. It was created specifically for this stack."
  policy = "${data.template_file.srv_account_kms_policy_template.rendered}"
}

resource "aws_kms_alias" "srv_account_alias" {
  name          = "alias/${var.tags_executedby}-kms"
  target_key_id = "${aws_kms_key.srv_account_kms.key_id}"
}



resource "aws_ssm_parameter" "ssm_git_private_key" {
  name        = "/${var.tags_executedby}/${var.ssm_github_priv_key}"
  description = "Let's use this for a service account for my personal git - its the private key"
  type        = "SecureString"
  value       = "${data.aws_ssm_parameter.git_private_key.value}"
  key_id      = "${aws_kms_key.srv_account_kms.key_id}"

}
resource "aws_ssm_parameter" "ssm_git_public_key" {
  name        = "/${var.tags_executedby}/${var.ssm_github_pub_key}"
  description = "Let's use this for a service account for my personal git - its the public key"
  type        = "SecureString"
  value       = "${data.aws_ssm_parameter.git_pub_key.value}"
  key_id      = "${aws_kms_key.srv_account_kms.key_id}"

}

###
# We will first create the bastion security group
# 
###

resource "aws_security_group" "bastion_tooling_sg" {
  name_prefix = "${var.bastion_tooling_sg_name}-"
  description = "Private security group for bastion server in the tooling VPC"
  vpc_id      = "${var.tools_vpc_id}"

  #Inbound SSH rules
  ingress {
    from_port       = "${var.ssh_port}"
    to_port         = "${var.ssh_port}"
    protocol        = "tcp"
    cidr_blocks     = "${var.all_inbound_cidrs}"
  }

  #All outbound traffic should be allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.all_outbound_cidrs}"
  }

#   tags = {
#     name          = "${var.bastion_tooling_sg_name}"
#     CostCentre    = "${var.tags_costcentre}"
#     ApplicationID = "${var.tags_applicationID}"
#     Owner         = "${var.tags_owner}"
#     ExecutedBy    = "${var.tags_executedby}"
#   }

  lifecycle {
    create_before_destroy = true
  }
}




resource "aws_security_group" "jenkins_tooling_sg" {
  name_prefix = "${var.jenkins_tooling_sg_name}-"
  description = "Private security group for Jenkins master in the tooling VPC"
  vpc_id      = "${var.tools_vpc_id}"

  #Inbound SSH rules
  ingress {
    from_port       = "${var.ssh_port}"
    to_port         = "${var.ssh_port}"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion_tooling_sg.id}"]
  }

  #Inbound Http
  ingress {
    from_port       = "${var.http_port}"
    to_port         = "${var.http_port}"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.jenkins_tooling_lb_sg.id}"]
  }

  #Inbound Https
  ingress {
    from_port       = "${var.https_port}"
    to_port         = "${var.https_port}"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.jenkins_tooling_lb_sg.id}"]
  }

  #All outbound traffic should be allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.all_outbound_cidrs}"
  }

#   tags = {
#     name          = "${var.bastion_tooling_sg_name}"
#     CostCentre    = "${var.tags_costcentre}"
#     ApplicationID = "${var.tags_applicationID}"
#     Owner         = "${var.tags_owner}"
#     ExecutedBy    = "${var.tags_executedby}"
#   }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "jenkins_tooling_lb_sg" {
  name_prefix = "${var.jenkins_tooling_lb_sg_name}-"
  description = "private security group for jenkins tooling server"
  vpc_id      = "${var.tools_vpc_id}"


  #Inbound Http
  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "tcp"
    cidr_blocks = "${var.all_inbound_cidrs}"
  }

  #Inbound Https
  ingress {
    from_port   = "${var.https_port}"
    to_port     = "${var.https_port}"
    protocol    = "tcp"
    cidr_blocks = "${var.all_inbound_cidrs}"
  }

  #All outbound traffic should be allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.all_outbound_cidrs}"
  }

  lifecycle {
    create_before_destroy = true
  }

}






