## Global
variable "http_port" {}
variable "https_port" {}
variable "vpc_id" {}



# module specific

variable "ami_owner_amazon" {}
variable "ami_filter_name" {}
variable "ami_filter_pattern_jenkins" {}
variable "ami_filter_pattern_bastion" {}


variable "bastion_instance_type" {}
variable "key_pair" {}

variable "subnet_id" {}
variable "subnet_ids" {}
variable "lb_cert_arn" {}
variable "jenkins_instance_type" {}


## Referenced from other modules

variable "jenkins_lb_sg" {}
variable "jenkins_instance_sg" {}
variable "jenkins_iam_profile" {}
variable "bastion_instance_sg" {}
variable "bastion_iam_profile" {}