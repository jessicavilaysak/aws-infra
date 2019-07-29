#------------computing/main.tf---------


data "aws_ami" "jenkins_ami" {
  most_recent = true

  owners = ["${var.ami_owner_amazon}"]

  filter {
    name   = "${var.ami_filter_name}"
    values = ["${var.ami_filter_pattern_jenkins}"]
  }
}

data "aws_ami" "bastion_ami" {
  most_recent = true

  owners = ["${var.ami_owner_amazon}"]

  filter {
    name   = "${var.ami_filter_name}"
    values = ["${var.ami_filter_pattern_bastion}"]
  }
}

resource "aws_instance" "bastion_instance" {
  instance_type = "${var.bastion_instance_type}"

  ami = "${data.aws_ami.bastion_ami.id}"

  # tags = {
  #   Name           = "${var.tags_bastion_instanceName}"
  #   Owner          = "${var.tags_owner}"
  #   CostCentre     = "${var.tags_costcentre}"
  #   ApplicationID  = "${var.tags_applicationID}"
  #   PowerMgt       = "${var.tags_powermgmt}"
  #   Environment    = "${var.tags_environment}"
  #   ExecutedBy     = "${var.tags_executedby}"
  #   LDAPAuthGroup  = "${var.tags_ldap_authgroup}"
  #   LDAPAuthDomain = "${var.tags_ldap_domain}"
  # }

  iam_instance_profile = "${var.bastion_iam_profile}"

  key_name               = "${var.key_pair}"
  vpc_security_group_ids = ["${var.bastion_instance_sg}"]
  subnet_id              = "${var.subnet_id}"

  #note that above is created from the networking module, so its output will be passed as param to this module
  #user_data = "${data.template_file.user-init.*.rendered[0]}"
}

