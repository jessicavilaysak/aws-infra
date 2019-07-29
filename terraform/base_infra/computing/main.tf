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

data "aws_availability_zones" "allzones" {}

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


## The target groups will be linked to each listener
resource "aws_lb_target_group" "jenkins_lb_http_target_group" {
  port     = "${var.http_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    //todo: look at all these hard codings
    interval          = "300"
    port              = "${var.http_port}"
    timeout           = "60"
    protocol          = "HTTP"
    healthy_threshold = "5"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "jenkins_lb_https_target_group" {
  port     = "${var.https_port}"
  protocol = "HTTPS"
  vpc_id   = "${var.vpc_id}"

  health_check {
    //todo: look at all these hard codings
    interval          = "300"
    port              = "${var.https_port}"
    timeout           = "60"
    protocol          = "HTTPS"
    healthy_threshold = "5"
  }

  lifecycle {
    create_before_destroy = true
  }
}

## The load balancer resource
resource "aws_lb" "jenkins_lb" {
  security_groups    = ["${var.jenkins_lb_sg}"]
  internal           = true
  load_balancer_type = "application"
  subnets            = "${var.subnet_ids}"

  # tags = {
  #   Name          = "${var.tags_jenkins_lb_name}"
  #   Owner         = "${var.tags_owner}"
  #   CostCentre    = "${var.tags_costcentre}"
  #   ApplicationID = "${var.tags_applicationID}"
  #   Environment   = "${var.tags_environment}"
  #   ExecutedBy    = "${var.tags_executedby}"
  # }

  lifecycle {
    create_before_destroy = true
  }
}


## Both the load balancer listeners
resource "aws_lb_listener" "jenkins_lb_http_listener" {
  load_balancer_arn = "${aws_lb.jenkins_lb.arn}"
  port              = "${var.http_port}"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.jenkins_lb_http_target_group.arn}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "jenkins_lb_https_listener" {
  load_balancer_arn = "${aws_lb.jenkins_lb.arn}"
  port              = "${var.https_port}"
  protocol          = "HTTPS"
  certificate_arn   = "${var.lb_cert_arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.jenkins_lb_target_group.arn}"
  }

  lifecycle {
    create_before_destroy = true
  }
}


## The resources for ASG and launch config
resource "aws_autoscaling_group" "jenkins_asg" {
  name = "jenkins-asg"

  vpc_zone_identifier       = "${var.subnet_ids}"
  availability_zones        = "${data.aws_availability_zones.allzones.names}"
  launch_configuration      = "${aws_launch_configuration.jenkins_launch_config.name}"
  min_size                  = "1"
  max_size                  = "1"
  health_check_grace_period = "300"
  target_group_arns = ["${aws_lb_target_group.jenkins_lb_http_target_group.arn}", "${aws_lb_target_group.jenkins_lb_https_target_group.arn}"]


  # tags = [
  #   {
  #     key                 = "Name"
  #     value               = "${var.tags_special_jenkins_asg_name}"
  #     propagate_at_launch = "true"
  #   },
  #   {
  #     key                 = "Owner"
  #     value               = "${var.tags_owner}"
  #     propagate_at_launch = "true"
  #   },
  #   {
  #     key                 = "CostCentre"
  #     value               = "${var.tags_costcentre}"
  #     propagate_at_launch = "true"
  #   },
  #   {
  #     key                 = "ApplicationID"
  #     value               = "${var.tags_applicationID}"
  #     propagate_at_launch = "true"
  #   },
  #   {
  #     key                 = "PowerMgt"
  #     value               = "${var.tags_powermgmt}"
  #     propagate_at_launch = "true"
  #   },
  #   {
  #     key                 = "Environment"
  #     value               = "${var.tags_environment}"
  #     propagate_at_launch = "true"
  #   },
  #   {
  #     key                 = "ExecutedBy"
  #     value               = "${var.tags_executedby}"
  #     propagate_at_launch = "true"
  #   },
  # ]

  lifecycle {
    create_before_destroy = true
  }

  //TODO: The following were not taken care of
  //UpdatePolicy:
  //  AutoScalingReplacingUpdate:
  //    WillReplace: true  
}

resource "aws_launch_configuration" "jenkins_launch_config" {
  instance_type        = "${var.jenkins_instance_type}"
  image_id             = "${data.aws_ami.server_ami_dev.id}"
  image_id = "${data.aws_ami.jenkins_ami.id}"
  iam_instance_profile = "${var.jenkins_iam_profile}"
  key_name             = "${var.key_pair}"
  security_groups      = ["${var.jenkins_instance_sg}"]

  #note that above is created from the networking module, so its output will be passed as param to this module
  #user_data = "${data.template_file.user-init.*.rendered[0]}"

  lifecycle {
    create_before_destroy = true
  }

}

