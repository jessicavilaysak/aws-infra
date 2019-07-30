#------------security_groups/main.tf---------

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




