

variable "ami_owner_amazon" {}
variable "ami_filter_name" {}
variable "ami_filter_pattern_jenkins" {}
variable "ami_filter_pattern_bastion" {}


variable "bastion_instance_type" {}
variable "bastion_iam_profile" {}
variable "key_pair" {}

variable "subnet_id" {}
variable "subnet_ids" {}
variable "bastion_instance_sg" {}
variable "jenkins_lb_sg" {}
variable "lb_cert_arn" {}
variable "jenkins_instance_type" {}
variable "jenkins_instance_sg" {}
variable "jenkins_iam_profile" {}
variable "http_port" {}
variable "https_port" {}
